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
        
        
    }
    return self;
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
    // 给popView传递数据
    self.popView.emotion = btn.emotion;
    
    // 取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.popView];
    
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height;
    self.popView.centerX = CGRectGetMidX(btnFrame);
    
    // 等会让popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    // 发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[BGASelectEmotionKey] = btn.emotion;
    [BGANotificationCenter postNotificationName:BGAEmotionDidSelectNotification object:nil userInfo:userInfo];
}

- (BGAEmotionPopView *)popView {
    if (!_popView) {
        _popView = [BGAEmotionPopView popView];
    }
    return _popView;
}

@end
