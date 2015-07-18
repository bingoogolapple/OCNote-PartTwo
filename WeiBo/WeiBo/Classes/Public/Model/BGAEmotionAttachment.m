//
//  BGAEmotionAttachment.m
//  WeiBo
//
//  Created by bingoogol on 15/7/19.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAEmotionAttachment.h"
#import "BGAEmotion.h"

@implementation BGAEmotionAttachment

- (void)setEmotion:(BGAEmotion *)emotion {
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}
@end
