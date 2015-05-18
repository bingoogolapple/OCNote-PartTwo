//
//  BGAStatus.m
//  WeiBo
//
//  Created by bingoogol on 15/5/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAStatus.h"

@implementation BGAStatus

+ (instancetype)statusWithDict:(NSDictionary *)dict {
    BGAStatus *status = [[self alloc] init];
    status.idstr = dict[@"idstr"];
    status.text = dict[@"text"];
    status.user = [BGAUser userWithDict:dict[@"user"]];
    return status;
}

@end