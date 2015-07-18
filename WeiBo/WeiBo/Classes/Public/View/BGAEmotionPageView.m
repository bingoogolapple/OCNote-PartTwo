//
//  BGAEmotionPageView.m
//  WeiBo
//
//  Created by bingoogol on 15/7/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAEmotionPageView.h"
#import "BGAEmotion.h"

@implementation BGAEmotionPageView

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i<count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        BGAEmotion *emotion = emotions[i];
        
        if (emotion.png) {
            // CUICatalog: Invalid asset name supplied: (null), or invalid scale factor: 2.000000
            // 警告原因：尝试去加载的图片不存在
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        } else if (emotion.code) {
            // 设置emoji
            [btn setTitle:emotion.code.emoji forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:32];
        }
        
        [self addSubview:btn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 内边距(四周)
    CGFloat inset = 20;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / BGAEmotionMaxCols;
    CGFloat btnH = (self.height - inset) / BGAEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i%BGAEmotionMaxCols) * btnW;
        btn.y = inset + (i/BGAEmotionMaxCols) * btnH;
    }
}

@end
