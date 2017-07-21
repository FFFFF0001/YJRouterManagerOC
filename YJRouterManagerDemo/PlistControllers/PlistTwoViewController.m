//
//  PlistTwoViewController.m
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "PlistTwoViewController.h"

@interface PlistTwoViewController ()

@end

@implementation PlistTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeCurrentController)];
}

- (void)closeCurrentController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.navigationController) {
        [YJRouterManager pushViewControllerUrl:@"yj://1103" parameter:nil navigationController:self.navigationController complete:nil];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
