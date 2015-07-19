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

+ (NSArray *)defaultEmotions;
+ (NSArray *)lxhEmotions;
+ (NSArray *)emojiEmotions;

/**
 *  通过表情描述找到对应的表情
 *
 *  @param chs 表情描述
 */
+ (BGAEmotion *)emotionWithChs:(NSString *)chs;
@end