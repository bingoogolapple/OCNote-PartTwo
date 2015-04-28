//
//  BGASettingGroup.h
//  Lottery
//
//  Created by bingoogol on 15/4/26.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGASettingGroup : NSObject

@property (nonatomic, copy) NSString *header;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) NSString *footer;

@end