//
//  YJRouterRequestManager.m
//  YJRouterManagerDemo
//
//  Created by YJHou on 2017/5/19.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "YJRouterRequestManager.h"

@implementation YJRouterRequestManager

+ (YJRouterRequestManager *)createRequestWithUrl:(NSString *)url parameter:(NSDictionary *)parameter showType:(YJRouterShowType)showType packingNavigationBlock:(YJPackingNavigationBlock)packingNavigationBlock createdComplete:(YJViewControllerCreatedBlock)createdComplete sourceController:(UIViewController *)sourceController{
    
    YJRouterRequestManager *request = [[YJRouterRequestManager alloc] init];
    request.showType = showType;
    request.sourceViewController = sourceController;
    request.packingNavigationBlock = packingNavigationBlock;
    
    [request analysisRouterUrl:url];
    if (parameter) {
        if (request.parameter) { // url 参数
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:request.parameter];
            for (NSString * key in parameter.allKeys) {
                [dict setObject:parameter[key] forKey:key];
            }
            request.parameter = [NSDictionary dictionaryWithDictionary:dict];
        }else {
            request.parameter = parameter;
        }
    }
    request.createdComplete = createdComplete;
    
    return request;
}

- (void)analysisRouterUrl:(NSString *)url{
    
    NSMutableString *newurl = [NSMutableString stringWithString:url];
    if ([newurl hasPrefix:[YJRouterManager sharedInstance].router_main_scheme]) {
        [newurl deleteCharactersInRange:NSMakeRange(0, [YJRouterManager sharedInstance].router_main_scheme.length)];
    }
    
    NSArray * componseArr = [newurl componentsSeparatedByString:@"?"];
    if (componseArr.count > 1) {
        self.code = componseArr.firstObject;
        NSString *parameterStr = componseArr.lastObject;
        NSDictionary *parameterDict = [self _getRouterParametersDictWithString:parameterStr];
        
        if (parameterDict.count > 0) {
            self.parameter = [NSDictionary dictionaryWithDictionary:parameterDict];
        }
    }else {
        self.code = newurl;
    }
}

- (NSDictionary *)_getRouterParametersDictWithString:(NSString *)string{
    
    NSString *parameterString = nil;
    if (self) {
        parameterString = [self _removeBlankForYJRouterWithString:string];
    }else{
        return nil;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray * queryComponents = [parameterString componentsSeparatedByString:@"&"];
    for (NSString *queryComponent in queryComponents) {
        NSArray *contents = [queryComponent componentsSeparatedByString:@"="];
        if(contents.count == 2) {
            NSString *key = [contents firstObject];
            NSString *value = [contents lastObject];
            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (key && value) {
                [dict setObject:value forKey:key];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}


- (NSString *)_removeBlankForYJRouterWithString:(NSString *)string{
    if (string == nil || [string isEqual:[NSNull null]]) { return nil; }
    return [string stringByReplacingOccurrencesOfString:@"\\s+" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, string.length)];
}

@end


