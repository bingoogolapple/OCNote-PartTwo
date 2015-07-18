//
//  BGAEmotionTabBar.m
//  WeiBo
//
//  Created by bingoogol on 15/7/17.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAEmotionTabBar.h"
#import "BGAEmotionTabBarButton.h"

@interface BGAEmotionTabBar ()
@property (nonatomic, weak) BGAEmotionTabBarButton *selectedBtn;
@end

@implementation BGAEmotionTabBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:BGAEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:BGAEmotionTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:BGAEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:BGAEmotionTabBarButtonTypeLxh];
    }
    return self;
}


/**
 *  创建一个按钮
 *
 *  @param title 按钮文字
 */
- (BGAEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(BGAEmotionTabBarButtonType)buttonType {
    // 创建按钮
    BGAEmotionTabBarButton *btn = [[BGAEmotionTabBarButton alloc] init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.tag = buttonType;
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];

    // 设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    return btn;
}

- (void)setDelegate:(id<BGAEmotionTabBarDelegate>)delegate {
    _delegate = delegate;
    [self btnClick:(BGAEmotionTabBarButton *)[self viewWithTag:BGAEmotionTabBarButtonTypeDefault]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        BGAEmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
}

/**
 *  按钮点击
 */
- (void)btnClick:(BGAEmotionTabBarButton *)btn {
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:btn.tag];
    }
}

@end