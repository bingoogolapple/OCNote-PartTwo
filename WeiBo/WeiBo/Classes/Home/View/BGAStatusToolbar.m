//
//  BGAStatusToolbar.m
//  WeiBo
//
//  Created by bingoogol on 15/6/17.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAStatusToolbar.h"

@interface BGAStatusToolbar()

@property (nonatomic, weak) UIButton *b;

@end

@implementation BGAStatusToolbar

+ (instancetype)toolbar {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        [self addBtnWithTitle:@"转发" icon:@"timeline_icon_retweet"];
        [self addBtnWithTitle:@"评论" icon:@"timeline_icon_comment"];
        [self addBtnWithTitle:@"赞" icon:@"timeline_icon_unlike"];
    }
    return self;
}

- (void)addBtnWithTitle:(NSString *)title icon:(NSString *)icon {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:BGAColor(200, 200, 200) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:btn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    UIButton *btn;
    for (int i = 0; i < count; i++) {
        btn = self.subviews[i];
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
    }
}

@end
