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

@interface BGAEmotionKeyboard ()

/** 表情内容 */
@property (nonatomic, weak) BGAEmotionListView *listView;
/** tabbar */
@property (nonatomic, weak) BGAEmotionTabBar *tabBar;

@end

@implementation BGAEmotionKeyboard

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1.表情内容
        BGAEmotionListView *listView = [[BGAEmotionListView alloc] init];
        listView.backgroundColor = BGARandomColor;
        [self addSubview:listView];
        self.listView = listView;
        
        // 2.tabbar
        BGAEmotionTabBar *tabBar = [[BGAEmotionTabBar alloc] init];
        tabBar.backgroundColor = BGARandomColor;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 1.tabbar
    self.tabBar.width = self.width;
    self.tabBar.height = 44;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    // 2.表情内容
    self.listView.x = self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.tabBar.y;
}

@end