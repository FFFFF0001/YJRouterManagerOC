//
//  PlistMainViewController.m
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "PlistMainViewController.h"
#import "PlistOneViewController.h"

@interface PlistMainViewController () <PlistOneViewControllerDelegate>

@end

@implementation PlistMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    __weak typeof(self) weakSelf = self;
    [YJRouterManager pushViewControllerUrl:@"yj://1101?userid=1024" parameter:@{@"name" : @"houmanager", @"email" : @"houmanager@hotmail.com"} navigationController:nil complete:^(UIViewController *toController) {
        ((PlistOneViewController *)toController).delegate = weakSelf;
    }];
}

#pragma mark - Delegate
- (void)oneControllerName:(NSString *)oneControllerName{
    NSLog(@"代理传递的控制名字: %@", oneControllerName);
}

@end
