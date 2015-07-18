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

@end

@implementation BGAEmotionPageView

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
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i%BGAEmotionMaxCols) * btnW;
        btn.y = inset + (i/BGAEmotionMaxCols) * btnH;
    }
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
}

- (BGAEmotionPopView *)popView {
    if (!_popView) {
        _popView = [BGAEmotionPopView popView];
    }
    return _popView;
}

@end
