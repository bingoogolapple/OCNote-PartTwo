//
//  BGASettingArrowItem.m
//  Lottery
//
//  Created by bingoogol on 15/4/26.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGASettingArrowItem.h"

@implementation BGASettingArrowItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass {
    BGASettingArrowItem *item = [super itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}

@end