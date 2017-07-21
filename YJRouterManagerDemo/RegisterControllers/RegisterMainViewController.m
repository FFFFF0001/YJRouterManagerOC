//
//  RegisterMainViewController.m
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "RegisterMainViewController.h"

@interface RegisterMainViewController ()

@end

@implementation RegisterMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [YJRouterManager pushViewControllerUrl:@"yj://R1101?id=125655" parameter:nil navigationController:nil complete:nil];
    
}

@end
