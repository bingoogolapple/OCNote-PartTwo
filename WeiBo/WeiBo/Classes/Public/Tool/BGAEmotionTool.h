//
//  BGAEmotionTool.h
//  WeiBo
//
//  Created by bingoogol on 15/7/19.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BGAEmotion;

@interface BGAEmotionTool : NSObject

+ (void)addRecentEmotion:(BGAEmotion *)emotion;
+ (NSArray *)recentEmotions;

@end