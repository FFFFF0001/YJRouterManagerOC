//
//  YJRouterManager.m
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "YJRouterManager.h"

#define YJROUTER_CONFIG_PLIST_FILE_NAME @"YJRouterManagerConfig" // 配置文件的名字
#define YJ_ROUTER_CLASS_NAME @"className"

@interface YJRouterManager ()

@property (nonatomic, assign) BOOL isRunning;           /**< 正在运行 */
@property (nonatomic, strong) UIWindow *keyWindow;      /**< 主窗口 */
@property (nonatomic, strong) NSDictionary *routerConfigs;   /**< 路由初始化数据 */
@property (nonatomic, strong) NSMutableArray *requestCurrentQueue;              /**< 请求跳转的当前队列 */
@property (nonatomic, strong) NSMutableDictionary *code_Controller_Dict;        /**< 路由码和控制器的对应关系 */
@property (nonatomic, strong) NSMutableDictionary *controller_Code_Dict;        /**< 控制器和路由码的对应关系 */
@property (nonatomic, strong) NSMutableDictionary *code_CustomInitBlock_Dict;   /**< 自定义初始化方法和code映射字典 */

@end

@implementation YJRouterManager

- (instancetype)init{
    self = [super init];
    if (self) {
        self.isRunning = NO;
        _router_main_scheme = @"yj://";
        
        // 加载plist数据
        for (NSInteger i = 0; i < self.routerConfigs.allKeys.count; i++) {
            NSString *code = self.routerConfigs.allKeys[i];
            NSString *className = [self.routerConfigs[code] objectForKey:YJ_ROUTER_CLASS_NAME];
            if ([code isKindOfClass:[NSString class]] && [className isKindOfClass:[NSString class]]) {
                [self.code_Controller_Dict setObject:className forKey:code];
                [self.controller_Code_Dict setObject:code forKey:className];
            }
        }
    }
    return self;
}

+ (YJRouterManager *)sharedInstance{
    static YJRouterManager *_instance_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance_ = [[YJRouterManager alloc] init];
    });
    return _instance_;
}

- (void)registerMainScheme:(NSString *)mainScheme keyWindow:(UIWindow *)keyWindow{
    if (mainScheme) {
        _router_main_scheme = mainScheme;
    }
    self.keyWindow = keyWindow;
}

+ (BOOL)canOpenWithCode:(NSString *)code{
    if ([[YJRouterManager sharedInstance].code_Controller_Dict objectForKey:code]) {
        return YES;
    }
    return NO;
}

+ (NSString *)getCodeWithClass:(Class)clazz{
    return [self getCodeWithClassName:NSStringFromClass(clazz)];
}

+ (NSString *)getCodeWithClassName:(NSString *)className{
    if ([className isKindOfClass:[NSString class]]) {
        return [[YJRouterManager sharedInstance].controller_Code_Dict objectForKey:className];
    }
    return nil;
}

#pragma mark - 注册
+ (void)registerRouterCode:(NSString *)code customInitBlock:(YJCustomInitBlock)customInitBlock{
    
    YJRouterManager *router = [YJRouterManager sharedInstance];
    if (customInitBlock) {
        if (code) {
            if ([router.code_Controller_Dict objectForKey:code]) {
                [router.code_CustomInitBlock_Dict setObject:customInitBlock forKey:code];
            }else {
                [self _addMapDictWithCode:code customInitBlock:customInitBlock];
            }
        }
    }else{
        if (![router.code_Controller_Dict objectForKey:code]) { // 不存在
            [self _addMapDictWithCode:code customInitBlock:customInitBlock];
        }
    }
}

#pragma mark - Push 方式
+ (void)pushViewControllerUrl:(NSString *)url parameter:(NSDictionary *)parameter navigationController:(UINavigationController *)navigationController complete:(YJViewControllerCreatedBlock)complete{
    [self _createRequestWithUrl:url parameter:parameter complete:complete packingNavigationBlock:nil showType:PUSH sourceController:navigationController];
}

#pragma mark - Present 方式
+ (void)presentViewControllerUrl:(NSString *)url parameter:(NSDictionary *)parameter showType:(YJRouterShowType)showType sourceViewController:(UIViewController *)sourceViewController packingNavigationBlock:(YJPackingNavigationBlock)packingNavigationBlock complete:(YJViewControllerCreatedBlock)complete{
    [self _createRequestWithUrl:url parameter:parameter complete:complete packingNavigationBlock:packingNavigationBlock showType:showType sourceController:sourceViewController];
}

#pragma mark - Private
+ (NSString *)_getRouterCodeWithUrl:(NSString *)url {
    NSMutableString * newurl = [NSMutableString stringWithString:url];
    if ([newurl hasPrefix:[YJRouterManager sharedInstance].router_main_scheme]) {
        [newurl deleteCharactersInRange:NSMakeRange(0, [YJRouterManager sharedInstance].router_main_scheme.length)];
    }
    NSArray *componseArr = [newurl componentsSeparatedByString:@"?"];
    return componseArr.firstObject;
}

- (void)startNextTask{
    if (self.requestCurrentQueue.count > 0 && !self.isRunning) {
        YJRouterRequestManager *request = self.requestCurrentQueue.firstObject;
        
        self.isRunning = YES;
        NSString *code = request.code;
        NSDictionary *parameter = request.parameter;
        YJRouterManager *router = [YJRouterManager sharedInstance];
        
        // 1.通过code取到类
        NSString *className = [router.code_Controller_Dict objectForKey:code];
        Class newClass = NSClassFromString(className);
        
        // 2. 取到对应的类
        if (newClass && [newClass isSubclassOfClass:[UIViewController class]]) {
            
            // 3.获取对应的控制器
            UIViewController *vc = nil;
            YJCustomInitBlock createBlock = [self.code_CustomInitBlock_Dict objectForKey:code];
            if (createBlock) {
                vc = createBlock(parameter);
                if (vc == nil) {
                    [self _finishCurrentRequestAndStartNext:request];
                    if (request.createdComplete) { request.createdComplete(nil); }
                    return;
                }
            }else {
                vc = [[newClass alloc] init];
            }
            
            // 4.给对应的控制器传递参数
            if (parameter) {
                [vc yjRouter:router parameter:parameter];
            }
            
            // 5.配置打开类型
            if (request.showType == PUSH) {
                vc.hidesBottomBarWhenPushed = YES;
                if (request.sourceViewController && [request.sourceViewController isKindOfClass:[UINavigationController class]]) {
                    [((UINavigationController *)request.sourceViewController) pushViewController:vc animated:YES];
                }else {
                    // 默认 keyWindow rootViewController是 TabBar
                    if ([self.keyWindow.rootViewController isKindOfClass:[UITabBarController class]]) {  // 默认 UITabBarController
                        UITabBarController *tabVC = (UITabBarController *)self.keyWindow.rootViewController;
                        UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
                        [pushClassStance pushViewController:vc animated:YES];
                    }else if ([self.keyWindow.rootViewController isKindOfClass:[UINavigationController class]]) { // UINavigationController
                        UINavigationController *pushClassStance = (UINavigationController *)self.keyWindow.rootViewController;
                        [pushClassStance pushViewController:vc animated:YES];
                    }
                }
                
                if (request.createdComplete) { request.createdComplete(vc); }
            }else {
                UIViewController * presentVC = nil;
                if (request.showType == PRESENT_WITH_NAVIGATION) {
                    if (request.packingNavigationBlock) {
                        UINavigationController *nav = request.packingNavigationBlock(vc);
                        if (nav) {
                            presentVC = nav;
                        }else {
                            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
                            presentVC = nav;
                        }
                    }else {
                        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
                        presentVC = nav;
                    }
                }else if (request.showType == PRESENT){
                    presentVC = vc;
                }
                
                if (!presentVC) { return; }
                
                if (request.sourceViewController) {
                    if ([request.sourceViewController respondsToSelector:@selector(presentViewController:animated:completion:)]) {
                        [request.sourceViewController presentViewController:presentVC animated:YES completion:nil];
                        
                        if (request.createdComplete) { request.createdComplete(vc);}
                    }else {
                        
                        if (request.createdComplete) { request.createdComplete(nil);}
                    }
                }else {
                    [self.keyWindow.rootViewController presentViewController:presentVC animated:YES completion:nil];
                    
                    if (request.createdComplete) { request.createdComplete(vc); }
                }
            }
        }else {
            
            if (request.createdComplete) { request.createdComplete(nil); }
        }
        
        [self _finishCurrentRequestAndStartNext:request];
    }
}

- (void)_finishCurrentRequestAndStartNext:(YJRouterRequestManager *)currentRequest{
    [self.requestCurrentQueue removeObject:currentRequest];
    self.isRunning = NO;
    [self startNextTask];
}

/** 创建请求 并添加到队列里 */
+ (void)_createRequestWithUrl:(NSString *)url parameter:(NSDictionary *)parameter complete:(YJViewControllerCreatedBlock)complete packingNavigationBlock:(YJPackingNavigationBlock)packingNavigationBlock showType:(YJRouterShowType)showType sourceController:(UIViewController *)sourceController{
    
    if (![self canOpenWithCode:[self _getRouterCodeWithUrl:url]]) {
        if (complete) { complete(nil); }
        return;
    }
    
    YJRouterRequestManager * request = [YJRouterRequestManager createRequestWithUrl:url parameter:parameter showType:showType packingNavigationBlock:packingNavigationBlock createdComplete:complete sourceController:sourceController];

    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[YJRouterManager sharedInstance].requestCurrentQueue addObject:request];
        [[YJRouterManager sharedInstance] startNextTask];
    });
}

+ (void)_addMapDictWithCode:(NSString *)code customInitBlock:(YJCustomInitBlock)customInitBlock{
    YJRouterManager *router = [YJRouterManager sharedInstance];
    NSString       *sourceString = [[NSThread callStackSymbols] objectAtIndex:2];
    NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
    NSMutableArray *array        = [NSMutableArray arrayWithArray:[sourceString  componentsSeparatedByCharactersInSet:separatorSet]];
    [array removeObject:@""];
    if (array.count > 3) {
        NSString *className = [array objectAtIndex:3];
        if (code && className) {
            [router.code_Controller_Dict setObject:className forKey:code];
            [router.controller_Code_Dict setObject:code forKey:className];
        }
        if (customInitBlock) {
            [router.code_CustomInitBlock_Dict setObject:customInitBlock forKey:code];
        }
    }
}

#pragma mark - Lazy
- (NSMutableArray *)requestCurrentQueue{
    if (!_requestCurrentQueue) {
        _requestCurrentQueue = [NSMutableArray array];
    }
    return _requestCurrentQueue;
}
- (NSMutableDictionary *)code_CustomInitBlock_Dict{
    if (!_code_CustomInitBlock_Dict) {
        _code_CustomInitBlock_Dict = [NSMutableDictionary dictionary];
    }
    return _code_CustomInitBlock_Dict;
}
- (NSDictionary *)routerConfigs{
    if (!_routerConfigs) {
        _routerConfigs = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:YJROUTER_CONFIG_PLIST_FILE_NAME ofType:@"plist"]];
    }
    return _routerConfigs;
}
-(NSMutableDictionary *)code_Controller_Dict{
    if (!_code_Controller_Dict) {
        _code_Controller_Dict = [NSMutableDictionary dictionary];
    }
    return _code_Controller_Dict;
}
- (NSMutableDictionary *)controller_Code_Dict{
    if (!_controller_Code_Dict) {
        _controller_Code_Dict = [NSMutableDictionary dictionary];
    }
    return _controller_Code_Dict;
}

+ (BOOL)accessInstanceVariablesDirectly{
    return NO;
}

@end


