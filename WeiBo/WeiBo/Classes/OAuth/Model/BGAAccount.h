//
//  BGAAccount.h
//  WeiBo
//
//  Created by bingoogol on 15/5/13.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGAAccount : NSObject
// 这样写能看到注释
/** string 用户调用access_token，接口获取授权后的access_token */
@property (nonatomic, copy) NSString *access_token;

/** string access_token生命周期，单位是秒 */
@property (nonatomic, copy) NSString *expires_in;

/** string 当前授权用户的UID */
@property (nonatomic, copy) NSString *uid;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end