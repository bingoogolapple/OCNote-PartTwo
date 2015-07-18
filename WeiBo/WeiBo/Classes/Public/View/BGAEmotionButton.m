
//
//  BGAEmotionButton.m
//  WeiBo
//
//  Created by bingoogol on 15/7/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAEmotionButton.h"
#import "BGAEmotion.h"

@implementation BGAEmotionButton
/**
 *  当控件不是从xib、storyboard中创建时，就会调用这个方法
 */
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 *  当控件是从xib、storyboard中创建时，就会调用这个方法
 */
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.titleLabel.font = [UIFont systemFontOfSize:32];
}

/**
 *  这个方法在initWithCoder:方法后调用
 */
- (void)awakeFromNib {
    
}

- (void)setEmotion:(BGAEmotion *)emotion {
    _emotion = emotion;
    if (emotion.png) {
        // CUICatalog: Invalid asset name supplied: (null), or invalid scale factor: 2.000000
        // 警告原因：尝试去加载的图片不存在
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        
        // 当按钮为System样式时，告诉系统不要渲染图片，否则会有一团蓝色
//        [self setImage:[[UIImage imageNamed:emotion.png] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    } else if (emotion.code) {
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }
}

@end
