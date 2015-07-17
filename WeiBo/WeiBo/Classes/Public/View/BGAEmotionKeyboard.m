//
//  BGAEmotionKeyboard.m
//  WeiBo
//
//  Created by bingoogol on 15/7/17.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAEmotionKeyboard.h"
#import "BGAEmotionListView.h"
#import "BGAEmotionTabBar.h"
#import "BGAEmotion.h"
#import "MJExtension.h"

@interface BGAEmotionKeyboard ()<BGAEmotionTabBarDelegate>

@property (nonatomic, weak) UIView *contentView;
/** 表情内容 */
@property (nonatomic, strong) BGAEmotionListView *recentListView;
@property (nonatomic, strong) BGAEmotionListView *defaultListView;
@property (nonatomic, strong) BGAEmotionListView *emojiListView;
@property (nonatomic, strong) BGAEmotionListView *lxhListView;
/** tabbar */
@property (nonatomic, weak) BGAEmotionTabBar *tabBar;

@end

@implementation BGAEmotionKeyboard

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1.表情内容
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        // 2.tabbar
        BGAEmotionTabBar *tabBar = [[BGAEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 1.tabbar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    // 2.表情内容
    self.contentView.x = self.contentView.y = 0;
    self.contentView.width = self.width;
    self.contentView.height = self.tabBar.y;
    // 3.设置frame
    UIView *child = [self.contentView.subviews lastObject];
    child.frame = self.contentView.bounds;
}

- (void)emotionTabBar:(BGAEmotionTabBar *)tabBar didSelectButton:(BGAEmotionTabBarButtonType)buttonType {
    // 移除contentView之前显示的控件
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (buttonType) {
        case BGAEmotionTabBarButtonTypeRecent: // 最近
            [self.contentView addSubview:self.recentListView];
            break;
        case BGAEmotionTabBarButtonTypeDefault: // 默认
            [self.contentView addSubview:self.defaultListView];
            break;
        case BGAEmotionTabBarButtonTypeEmoji: // Emoji
            [self.contentView addSubview:self.emojiListView];
            break;
        case BGAEmotionTabBarButtonTypeLxh: // Lxh
            [self.contentView addSubview:self.lxhListView];
            break;
    }
    
    // 重新计算子控件的frame(setNeedsLayout内部会在恰当的时刻，重新调用layoutSubviews，重新布局子控件)
    [self setNeedsLayout];
}

- (BGAEmotionListView *)recentListView {
    if (!_recentListView) {
        self.recentListView = [[BGAEmotionListView alloc] init];
        self.recentListView.backgroundColor = BGARandomColor;
    }
    return _recentListView;
}

- (BGAEmotionListView *)defaultListView {
    if (!_defaultListView) {
        self.defaultListView = [[BGAEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultListView.emotions = [BGAEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.defaultListView.backgroundColor = BGARandomColor;
    }
    return _defaultListView;
}

- (BGAEmotionListView *)emojiListView {
    if (!_emojiListView) {
        self.emojiListView = [[BGAEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [BGAEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.emojiListView.backgroundColor = BGARandomColor;
    }
    return _emojiListView;
}

- (BGAEmotionListView *)lxhListView {
    if (!_lxhListView) {
        self.lxhListView = [[BGAEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhListView.emotions = [BGAEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.lxhListView.backgroundColor = BGARandomColor;
    }
    return _lxhListView;
}

@end