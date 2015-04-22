//
//  BGATabBar.m
//  Lottery
//
//  Created by bingoogol on 15/4/22.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGATabBar.h"
#import "BGATabBarButton.h"

@interface BGATabBar()

@property (nonatomic, weak) BGATabBarButton *selectedBtn;

@end

@implementation BGATabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        Logger(@"创建BGATabBar");
        [self addBtns];
    }
    return self;
}

- (void)addBtns {
    NSString *imageName = nil;
    for (int i = 0; i < 5; i++) {
        BGATabBarButton *btn = [BGATabBarButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        // 设置按钮图片
        imageName = [NSString stringWithFormat:@"TabBar%d", i + 1];
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        imageName = [NSString stringWithFormat:@"TabBar%dSel", i + 1];
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
        // 监听按钮的点击
        [btn addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
        
        if (i == 0) {
            [self onClickBtn:btn];
        }
    }
}

- (void)onClickBtn:(BGATabBarButton *)button {
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
//    if (self.block) {
//        self.block(button.tag);
//    }
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedIndex:)]) {
        [self.delegate tabBar:self didSelectedIndex:button.tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 注意：要减掉两个子控件，背景和顶部分割线 UIImageView _UITabBarBackgroundView
    CGFloat btnW = self.bounds.size.width / (self.subviews.count - 2);
    CGFloat btnH = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    Logger(@"subviews.count = %d", self.subviews.count);
    for (int i = 0; i < self.subviews.count - 2; i++) {
        BGATabBarButton *btn = self.subviews[i + 1];
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}


@end