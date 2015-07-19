//
//  BGAHttpTool.m
//  WeiBo
//
//  Created by bingoogol on 15/7/19.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAHttpTool.h"
#import "AFNetworking.h"

@implementation BGAHttpTool

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure {
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure {
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 默认的序列化器就是json
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // Request failed: unacceptable content-type: text/plain   新浪返回的头不是json，但是又是json格式的字符串，修改AFJSONResponseSerializer源码，设置可接收的格式
    
    // 2.发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
