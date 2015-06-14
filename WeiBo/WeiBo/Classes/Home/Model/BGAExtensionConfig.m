//
//  BGAExtensionConfig.m
//  WeiBo
//
//  Created by bingoogol on 15/6/15.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAExtensionConfig.h"
#import "MJExtension.h"
#import "BGAStatus.h"

@implementation BGAExtensionConfig

/**
 *  这个方法会在BGAExtensionConfig加载进内存时调用一次
 */
+ (void)load {
    [BGAStatus setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"pic_urls":@"BGAPhoto"
                 };
    }];
}

@end
