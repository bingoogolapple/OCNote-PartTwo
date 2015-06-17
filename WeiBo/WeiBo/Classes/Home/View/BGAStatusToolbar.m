//
//  BGAStatusToolbar.m
//  WeiBo
//
//  Created by bingoogol on 15/6/17.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAStatusToolbar.h"
#import "BGAStatus.h"

@interface BGAStatusToolbar()

/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@end

@implementation BGAStatusToolbar

+ (instancetype)toolbar {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        self.repostBtn = [self addBtnWithTitle:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self addBtnWithTitle:@"评论" icon:@"timeline_icon_comment"];
        self.attitudeBtn = [self addBtnWithTitle:@"赞" icon:@"timeline_icon_unlike"];
        
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

- (UIButton *)addBtnWithTitle:(NSString *)title icon:(NSString *)icon {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:BGAColor(200, 200, 200) forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

- (void)setupDivider {
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置按钮的frame
    int btnCount = self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
    }
    
    // 设置分割线的frame
    int dividerCount = self.dividers.count;
    for (int i = 0; i < dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.frame = CGRectMake((i + 1) * btnW, 0, 1, btnH);
    }
}

- (NSMutableArray *)btns {
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers {
    if (!_dividers) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (void)setStatus:(BGAStatus *)status {
    _status = status;
    
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
}

// 将要有提示的参数放前面，中文放后面
- (void)setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title {
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d", count];
        } else {
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            // 将字符串里面的.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
@end
