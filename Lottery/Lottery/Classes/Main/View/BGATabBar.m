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
    }
    return self;
}

- (void)addTabBarButtonWithImgName:(NSString *)imgName selectedImgName:(NSString *)selectedImgName {
    BGATabBarButton *btn = [BGATabBarButton buttonWithType:UIButtonTypeCustom];
    
    // 设置按钮图片
    [btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImgName] forState:UIControlStateSelected];
    // 监听按钮的点击
    [btn addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    
    Logger(@"%d", self.subviews.count);
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
        //从1开始，除去第一个子控件
        BGATabBarButton *btn = self.subviews[i + 1];
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        btn.tag = i;
        if (btn.tag == 0) {
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

@end