//
//  BGALocal.m
//  WeiBo
//
//  Created by bingoogol on 15/5/12.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGALocal.h"

@implementation BGALocal

+ (instancetype)localWithDict:(NSDictionary *)dict {
    BGALocal *local = [[self alloc] init];
    local.clientId = dict[@"clientId"];
    local.clientSecret = dict[@"clientSecret"];
    local.redirectUri = dict[@"redirectUri"];
    return local;
}

@end