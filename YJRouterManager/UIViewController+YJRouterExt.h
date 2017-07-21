//
//  UIViewController+YJRouterExt.h
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJRouterManager;
@interface UIViewController (YJRouterExt)

/**
 控制传参数接收方法

 @param router 路由器
 @param parameter 传递的参数
 */
- (void)yjRouter:(YJRouterManager *)router parameter:(NSDictionary *)parameter;

@end
