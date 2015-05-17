//
//  BGAAccount.h
//  WeiBo
//
//  Created by bingoogol on 15/5/13.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGAAccount : NSObject<NSCoding>
// 这样写能看到注释
/** string 用户调用access_token，接口获取授权后的access_token */
@property (nonatomic, copy) NSString *access_token;

/** number access_token生命周期，单位是秒 */
@property (nonatomic, copy) NSNumber *expires_in;

/** string 当前授权用户的UID */
@property (nonatomic, copy) NSString *uid;

/** date access_token的创建时间 */
@property (nonatomic, strong) NSDate *created_time;

/** date 用户昵称 */
@property (nonatomic, strong) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end