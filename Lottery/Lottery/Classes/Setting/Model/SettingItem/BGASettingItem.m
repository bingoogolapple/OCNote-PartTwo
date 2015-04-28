//
//  BGASettingItem.m
//  Lottery
//
//  Created by bingoogol on 15/4/26.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGASettingItem.h"

@implementation BGASettingItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title {
    // BGASettingItem *item = [[BGASettingItem alloc] init];
    // 不能像上面那样写，因为有可能以后有子类，应该谁调用该方法就创建谁
    BGASettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}

@end