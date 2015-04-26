//
//  BGASettingItem.h
//  Lottery
//
//  Created by bingoogol on 15/4/26.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGASettingItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

@end