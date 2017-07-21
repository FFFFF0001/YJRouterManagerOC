//
//  YJRouterManager.h
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJRouterRequestManager.h"
#import "UIViewController+YJRouterExt.h"

@interface YJRouterManager : NSObject

@property (nonatomic, copy, readonly) NSString *router_main_scheme; /**< 协议名称 默认是 yj:// */

+ (YJRouterManager *)sharedInstance;

/**
 初始化注册路由器设置

 @param mainScheme 路由协议 不传默认是 "yj://"
 @param keyWindow 主窗口
 */
- (void)registerMainScheme:(NSString *)mainScheme
                 keyWindow:(UIWindow *)keyWindow;

/** 是否可以打开对应 code */
+ (BOOL)canOpenWithCode:(NSString *)code;

/** 获取类对应的  路由码Code */
+ (NSString *)getCodeWithClass:(Class)clazz;
+ (NSString *)getCodeWithClassName:(NSString *)className;

#pragma mark - 注册

/**
 注册对应控制器 在 + (void)load{} 方法中进行注册

 @param code 路由码
 @param customInitBlock 自定义初始化方法 如果是nil，默认是alloc init
 */
+ (void)registerRouterCode:(NSString *)code
           customInitBlock:(YJCustomInitBlock)customInitBlock;

#pragma mark - Push 方式
/**
  push 方式打开

 @param url 路由url 比如: "yj://1101?id=2001"
 @param parameter 参数字典
 @param navigationController 导航控制器 如果是nil, 默认当前导航 并不是present的导航
 @param complete 初始化完成的回调
 */
+ (void)pushViewControllerUrl:(NSString *)url parameter:(NSDictionary *)parameter navigationController:(UINavigationController *)navigationController complete:(YJViewControllerCreatedBlock)complete;

#pragma mark - Present 方式
/**
 present 方式打开

 @param url 路由url 比如: "yj://1101?id=2001"
 @param parameter 参数字典
 @param showType 显示类型 带导航还是不带
 @param sourceViewController 起始控制器 如果是nil 默认是window根控制器
 @param packingNavigationBlock 包装导航方法
 @param complete 初始化完成的回调
 */
+ (void)presentViewControllerUrl:(NSString *)url parameter:(NSDictionary *)parameter showType:(YJRouterShowType)showType sourceViewController:(UIViewController *)sourceViewController packingNavigationBlock:(YJPackingNavigationBlock)packingNavigationBlock complete:(YJViewControllerCreatedBlock)complete;

@end



