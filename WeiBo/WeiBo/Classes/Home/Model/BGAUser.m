//
//  BGAUser.m
//  WeiBo
//
//  Created by bingoogol on 15/5/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAUser.h"

@implementation BGAUser

+ (instancetype)userWithDict:(NSDictionary *)dict {
    BGAUser *user = [[self alloc] init];
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    return user;
}

@end