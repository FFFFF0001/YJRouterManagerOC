//
//  YJRouterRequestManager.h
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YJRouterShowType) {
    PUSH = 0,                   // PUSH
    PRESENT,                    // 模态
    PRESENT_WITH_NAVIGATION     // 带导航的模态
};

/** 由 路由码code 创建完viewController 回调 */
typedef void(^YJViewControllerCreatedBlock)(UIViewController *toController);

/** 将 toController 包装导航后 返回导航 */
typedef UINavigationController *(^YJPackingNavigationBlock)(UIViewController *toController);

/** 自定义初始化方法 */
typedef UIViewController *(^YJCustomInitBlock)(NSDictionary *parameter);


@interface YJRouterRequestManager : NSObject

@property (nonatomic, copy) NSString *code;                 /**< 路由码 */
@property (nonatomic, strong) NSDictionary * parameter;     /**< 携带参数 */
@property (nonatomic, copy) YJViewControllerCreatedBlock createdComplete;
@property (nonatomic, copy) YJPackingNavigationBlock packingNavigationBlock;
@property (nonatomic, assign) YJRouterShowType showType;
@property (nonatomic, weak) UIViewController *sourceViewController;

+ (YJRouterRequestManager *)createRequestWithUrl:(NSString *)url parameter:(NSDictionary *)parameter showType:(YJRouterShowType)showType packingNavigationBlock:(YJPackingNavigationBlock)packingNavigationBlock createdComplete:(YJViewControllerCreatedBlock)createdComplete sourceController:(UIViewController *)sourceController;

@end
