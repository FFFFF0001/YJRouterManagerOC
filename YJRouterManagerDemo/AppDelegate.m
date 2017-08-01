//
//  AppDelegate.m
//  YJRouterManagerDemo
//
//  Created by YJHou on 2016/5/19.
//  Copyright © 2016年 侯跃军. All rights reserved.
//

#import "AppDelegate.h"
#import "PlistMainViewController.h"
#import "RegisterMainViewController.h"
#import "HybridMainViewController.h"
#import "YJRouterManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    // 初始化路由器
    [[YJRouterManager sharedInstance] registerMainScheme:nil keyWindow:self.window];
    
    
    PlistMainViewController *vc = [[PlistMainViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = @"Plist注册";
    
    RegisterMainViewController *vc1 = [[RegisterMainViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    nav1.tabBarItem.title = @"手动注册";
    
    HybridMainViewController *vc2 = [[HybridMainViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    nav2.tabBarItem.title = @"混合注册";
    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.view.backgroundColor = [UIColor whiteColor];
    tabVC.viewControllers = @[nav, nav1, nav2];
    
    self.window.rootViewController = tabVC;

    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
