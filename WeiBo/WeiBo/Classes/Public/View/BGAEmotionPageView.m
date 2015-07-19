//
//  BGAEmotionPageView.m
//  WeiBo
//
//  Created by bingoogol on 15/7/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAEmotionPageView.h"
#import "BGAEmotion.h"
#import "BGAEmotionButton.h"
#import "BGAEmotionPopView.h"
#import "BGAEmotionTool.h"

@interface BGAEmotionPageView ()

@property (nonatomic, strong) BGAEmotionPopView *popView;
@property (nonatomic, weak) UIButton *deleteButton;
@end

@implementation BGAEmotionPageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        // 2.添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}

/**
 *  在这个方法中处理长按手势
 */
- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:recognizer.view];
    // 获得手指所在的位置\所在的表情按钮
    BGAEmotionButton *btn = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: // 手指已经不再触摸pageView
            // 移除popView
            [self.popView removeFromSuperview];
            // 如果手指还在表情按钮上
            if (btn) {
                // 发出通知
                [self selectEmotion:btn.emotion];
            }
            break;
        case UIGestureRecognizerStateBegan: // 手势开始（刚检测到长按）
        case UIGestureRecognizerStateChanged: { // 手势改变（手指的位置改变）
            [self.popView showFrom:btn];
            break;
        }
        default:
            break;
    }
}

/**
 *  根据手指位置所在的表情按钮
 */
- (BGAEmotionButton *)emotionButtonWithLocation:(CGPoint)location {
    NSUInteger count = self.emotions.count;
    for (int i = 0; i<count; i++) {
        BGAEmotionButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            // 已经找到手指所在的表情按钮了，就没必要再往下遍历
            return btn;
        }
    }
    return nil;
}

- (void)deleteClick {
    [BGANotificationCenter postNotificationName:BGAEmotionDidDeleteNotification object:nil];
}

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i<count; i++) {
        BGAEmotionButton *btn = [[BGAEmotionButton alloc] init];
        [self addSubview:btn];
        btn.emotion = emotions[i];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
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
        // 第一个时删除按钮，这里加1
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i%BGAEmotionMaxCols) * btnW;
        btn.y = inset + (i/BGAEmotionMaxCols) * btnH;
    }
    
    // 删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.y = self.height - btnH;
    self.deleteButton.x = self.width - inset - btnW;
}

- (void)btnClick:(BGAEmotionButton *)btn {
    // 显示popView
    [self.popView showFrom:btn];
    
    // 等会让popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    // 发出通知
    [self selectEmotion:btn.emotion];
}

- (void)selectEmotion:(BGAEmotion *)emotion {
    // 将这个表情存进沙盒
    [BGAEmotionTool addRecentEmotion:emotion];
    
    // 发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[BGASelectEmotionKey] = emotion;
    [BGANotificationCenter postNotificationName:BGAEmotionDidSelectNotification object:nil userInfo:userInfo];
}

- (BGAEmotionPopView *)popView {
    if (!_popView) {
        _popView = [BGAEmotionPopView popView];
    }
    return _popView;
}

@end
