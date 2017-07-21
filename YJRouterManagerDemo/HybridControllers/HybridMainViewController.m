//
//  HybridMainViewController.m
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//
#import "HybridMainViewController.h"

@interface HybridMainViewController ()

@end

@implementation HybridMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [YJRouterManager pushViewControllerUrl:@"H1101" parameter:nil navigationController:nil complete:nil];
}

@end
