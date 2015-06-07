//
//  BGATitleButton.m
//  Lottery
//
//  Created by bingoogol on 15/4/24.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGATitleButton.h"
#import <Availability.h>

#define BGAMargin 5

@implementation BGATitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        // 如果只涉及到两张时，一开始写好图片，接下来只要设置selected
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    // 想要彻底的改变一个空间的尺寸，就在setFrame中改。拦截设置按钮尺寸的过程
    frame.size.width += BGAMargin;
    [super setFrame:frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 这种方式在iOS8上有问题
    // 如果仅仅是调整按钮内部的titleLabel和imageView的位置，那么直接在layoutSubviews中单独设置位置即可
    // 1.计算titleLabel的frame
    self.titleLabel.x = self.imageView.x;
    // 2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + BGAMargin;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
