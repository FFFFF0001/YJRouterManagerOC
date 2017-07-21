//
//  PlistOneViewController.m
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "PlistOneViewController.h"

@interface PlistOneViewController ()

@end

@implementation PlistOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(oneControllerName:)]) {
        [self.delegate oneControllerName:NSStringFromClass([self class])];
    }
    
    [YJRouterManager presentViewControllerUrl:@"yj://1102" parameter:nil showType:PRESENT_WITH_NAVIGATION sourceViewController:self packingNavigationBlock:nil complete:nil];
}

- (void)yjRouter:(YJRouterManager *)router parameter:(NSDictionary *)parameter{
    NSLog(@"传递的参数是-->%@", parameter);
}

@end
