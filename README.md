#YJRouterManagerDemo

[![Travis](https://img.shields.io/travis/YJManager/YJBannerViewOC.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)
[![Language](https://img.shields.io/badge/Language-Objective--C-FF7F24.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)
[![CocoaPods](https://img.shields.io/cocoapods/p/YJBannerView.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)
[![CocoaPods](https://img.shields.io/cocoapods/v/YJBannerView.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)
[![GitHub tag](https://img.shields.io/github/tag/YJManager/YJBannerViewOC.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)
[![license](https://img.shields.io/github/license/YJManager/YJBannerViewOC.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)

### 效果
<img src="https://github.com/YJManager/YJBannerViewOC/blob/master/YJBannerViewDemo/Resources/Effect.gif" width="300" height="533" />

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
##### 方式一
<img src="https://github.com/YJManager/YJBannerViewOC/blob/master/YJBannerViewDemo/Resources/Effect.gif" width="300" height="533" />
##### 方式二
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
