//
//  BGASettingItem.h
//  Lottery
//
//  Created by bingoogol on 15/4/26.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BGASettingItemOption)();

@interface BGASettingItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

// 保存一段功能，在恰当的时候调用
@property (nonatomic, copy) BGASettingItemOption option;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

@end