//
//  BGATabBar.m
//  WeiBo
//
//  Created by bingoogol on 15/5/6.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGATabBar.h"

@interface BGATabBar()
@property (nonatomic, weak) UIButton *plusBtn;
@end

@implementation BGATabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn addTarget:self action:@selector(onClickPlusBtn) forControlEvents:UIControlEventTouchUpInside];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}

- (void)onClickPlusBtn {
    if ([self.delegate respondsToSelector:@selector(tabBarOnClickPlusBtn:)]) {
        [self.delegate tabBarOnClickPlusBtn:self];
    }
}

- (void)layoutSubviews {
    // 不能删，一定要调用，因为还要设置背景
    [super layoutSubviews];
    Logger(@"%@", self.subviews);
    [self setupPlusBtn];
    
    [self setupTabBarButton];
}

- (void)setupPlusBtn {
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
}

- (void)setupTabBarButton {
    int count = self.subviews.count;
    CGFloat tabbarButtonW = self.width / (count - 2);
    CGFloat tabbarButtonIndex = 0;

    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabbarButtonW;
            child.x = tabbarButtonIndex * tabbarButtonW;
            tabbarButtonIndex++;
            
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
        }
    }
}

@end