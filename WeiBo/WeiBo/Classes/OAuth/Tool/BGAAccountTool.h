//
//  BGAAccountTool.h
//  WeiBo
//
//  Created by bingoogol on 15/5/13.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGAAccount.h"
// @class BGAAccount   改用import，这样以后用到BGAAccountTool时就自动引入BGAAccount

@interface BGAAccountTool : NSObject

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(BGAAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (BGAAccount *)account;

@end