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
#import "BGAEmotionTool.h"

@interface BGAEmotionKeyboard ()<BGAEmotionTabBarDelegate>

@property (nonatomic, weak) BGAEmotionListView *showingListView;
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
        BGAEmotionTabBar *tabBar = [[BGAEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        // 表情选中的通知
        [BGANotificationCenter addObserver:self selector:@selector(emotionDidSelect) name:BGAEmotionDidSelectNotification object:nil];
    }
    return self;
}

- (void)emotionDidSelect {
    self.recentListView.emotions = [BGAEmotionTool recentEmotions];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 1.tabbar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    // 2.表情内容
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
}

- (void)emotionTabBar:(BGAEmotionTabBar *)tabBar didSelectButton:(BGAEmotionTabBarButtonType)buttonType {
    // 移除正在显示的listView控件
    [self.showingListView removeFromSuperview];
    
    switch (buttonType) {
        case BGAEmotionTabBarButtonTypeRecent:
            [self addSubview:self.recentListView];
            break;
        case BGAEmotionTabBarButtonTypeDefault:
            [self addSubview:self.defaultListView];
            break;
        case BGAEmotionTabBarButtonTypeEmoji:
            [self addSubview:self.emojiListView];
            break;
        case BGAEmotionTabBarButtonTypeLxh:
            [self addSubview:self.lxhListView];
            break;
    }
    
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    // 重新计算子控件的frame(setNeedsLayout内部会在恰当的时刻，重新调用layoutSubviews，重新布局子控件)
    [self setNeedsLayout];
}

- (BGAEmotionListView *)recentListView {
    if (!_recentListView) {
        self.recentListView = [[BGAEmotionListView alloc] init];
        // 加载沙盒中的数据
        self.recentListView.emotions = [BGAEmotionTool recentEmotions];
    }
    return _recentListView;
}

- (BGAEmotionListView *)defaultListView {
    if (!_defaultListView) {
        self.defaultListView = [[BGAEmotionListView alloc] init];
        self.defaultListView.emotions = [BGAEmotionTool defaultEmotions];
    }
    return _defaultListView;
}

- (BGAEmotionListView *)emojiListView {
    if (!_emojiListView) {
        self.emojiListView = [[BGAEmotionListView alloc] init];
        self.emojiListView.emotions = [BGAEmotionTool emojiEmotions];
    }
    return _emojiListView;
}

- (BGAEmotionListView *)lxhListView {
    if (!_lxhListView) {
        self.lxhListView = [[BGAEmotionListView alloc] init];
        self.lxhListView.emotions = [BGAEmotionTool lxhEmotions];
    }
    return _lxhListView;
}

@end