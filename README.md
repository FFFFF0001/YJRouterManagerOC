#YJRouterManagerDemo

[![Travis](https://img.shields.io/travis/YJManager/YJRouterManagerOC.svg)](https://github.com/YJManager/YJRouterManagerOC.git)
[![Language](https://img.shields.io/badge/Language-Objective--C-FF7F24.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)
[![GitHub tag](https://img.shields.io/github/tag/eYJManager/YJRouterManagerOC.svg)](https://github.com/YJManager/YJRouterManagerOC.git)

### 效果
<img src="https://github.com/YJManager/YJRouterManagerOC/blob/master/YJRouterManagerDemo/Resource/bgAnimation.gif" width="300" height="533" />

### 使用方法
#### 在 AppDelegate 初始化注册
```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

    // 初始化路由器
    [[YJRouterManager sharedInstance] registerMainScheme:nil keyWindow:self.window];

    // 其他设置...

    [self.window makeKeyAndVisible];
return YES;
}
```

#### 在 YJRouterManagerConfig.plist 配置映射关系 或者 在控制器中手动注册
##### Plist 方式
<img src="https://github.com/YJManager/YJRouterManagerOC/blob/master/YJRouterManagerDemo/Resource/routerPlist.png" width="729" height="311" />
##### 控制器注册方式

```objc

+ (void)load{
    [YJRouterManager registerRouterCode:@"R1101" customInitBlock:nil];
}

```

#### Push 方式
```objc
/**
push 方式打开

@param url 路由url 比如: "yj://1101?id=2001"
@param parameter 参数字典
@param navigationController 导航控制器 如果是nil, 默认当前导航 并不是present的导航
@param complete 初始化完成的回调
*/
+ (void)pushViewControllerUrl:(NSString *)url parameter:(NSDictionary *)parameter navigationController:(UINavigationController *)navigationController complete:(YJViewControllerCreatedBlock)complete;
```

#### Present 方式
```objc
/**
present 方式打开

@param url 路由url 比如: "yj://1101?id=2001"
@param parameter 参数字典
@param showType 显示类型 带导航还是不带
@param sourceViewController 起始控制器 如果是nil 默认是window根控制器
@param packingNavigationBlock 包装导航方法
@param complete 初始化完成的回调
*/
+ (void)presentViewControllerUrl:(NSString *)url parameter:(NSDictionary *)parameter showType:(YJRouterShowType)showType sourceViewController:(UIViewController *)sourceViewController packingNavigationBlock:(YJPackingNavigationBlock)packingNavigationBlock complete:(YJViewControllerCreatedBlock)complete
```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
