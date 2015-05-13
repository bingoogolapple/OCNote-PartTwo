//
//  BGAAccount.m
//  WeiBo
//
//  Created by bingoogol on 15/5/13.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAAccount.h"

@implementation BGAAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    BGAAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    return account;
}

@end