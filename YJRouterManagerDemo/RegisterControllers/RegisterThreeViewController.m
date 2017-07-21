//
//  RegisterThreeViewController.m
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "RegisterThreeViewController.h"

@interface RegisterThreeViewController ()

@end

@implementation RegisterThreeViewController

+ (void)load{
    [YJRouterManager registerRouterCode:@"R1103" customInitBlock:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
