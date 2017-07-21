//
//  HybridTwoViewController.m
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "HybridTwoViewController.h"

@interface HybridTwoViewController ()

@end

@implementation HybridTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeCurrentController)];
}

- (void)closeCurrentController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [YJRouterManager pushViewControllerUrl:@"yj://H1103?id=125655" parameter:nil navigationController:self.navigationController complete:nil];
    
}


@end
