//
//  RegisterOneViewController.m
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "RegisterOneViewController.h"

@interface RegisterOneViewController ()

@end

@implementation RegisterOneViewController

+ (void)load{
    [YJRouterManager registerRouterCode:@"R1101" customInitBlock:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yjRouter:(YJRouterManager *)router parameter:(NSDictionary *)parameter{
    NSLog(@"RegisterOneViewController传递参数: %@", parameter);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [YJRouterManager presentViewControllerUrl:@"yj://R1102" parameter:nil showType:PRESENT_WITH_NAVIGATION sourceViewController:self packingNavigationBlock:nil complete:nil];
}

@end
