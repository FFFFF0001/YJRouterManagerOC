//
//  HybridOneViewController.m
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "HybridOneViewController.h"

@interface HybridOneViewController ()

@end

@implementation HybridOneViewController

+ (void)load{
    [YJRouterManager registerRouterCode:@"H1101" customInitBlock:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [YJRouterManager presentViewControllerUrl:@"yj://H1102" parameter:nil showType:PRESENT_WITH_NAVIGATION sourceViewController:self packingNavigationBlock:nil complete:nil];
}

@end
