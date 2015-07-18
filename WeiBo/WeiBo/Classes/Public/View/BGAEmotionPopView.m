//
//  BGAEmotionPopView.m
//  WeiBo
//
//  Created by bingoogol on 15/7/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAEmotionPopView.h"
#import "BGAEmotion.h"
#import "BGAEmotionButton.h"

@interface BGAEmotionPopView ()

@property (weak, nonatomic) IBOutlet BGAEmotionButton *emotionButton;

@end

@implementation BGAEmotionPopView

+ (instancetype)popView {
    return [[[NSBundle mainBundle] loadNibNamed:@"BGAEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)setEmotion:(BGAEmotion *)emotion {
    _emotion = emotion;
    self.emotionButton.emotion = emotion;
}

@end
