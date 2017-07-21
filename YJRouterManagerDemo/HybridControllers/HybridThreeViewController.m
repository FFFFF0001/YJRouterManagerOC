//
//  HybridThreeViewController.m
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "HybridThreeViewController.h"

@interface HybridThreeViewController ()

@end

@implementation HybridThreeViewController

+ (void)load{
    [YJRouterManager registerRouterCode:@"H1103" customInitBlock:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yjRouter:(YJRouterManager *)router parameter:(NSDictionary *)parameter{
    NSLog(@"传递的参数是-->%@", parameter);
}

@end
