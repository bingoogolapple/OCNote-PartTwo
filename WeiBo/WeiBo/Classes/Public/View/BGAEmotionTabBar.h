//
//  BGAEmotionTabBar.h
//  WeiBo
//
//  Created by bingoogol on 15/7/17.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BGAEmotionTabBarButtonTypeRecent, // 最近
    BGAEmotionTabBarButtonTypeDefault, // 默认
    BGAEmotionTabBarButtonTypeEmoji, // emoji
    BGAEmotionTabBarButtonTypeLxh, // 浪小花
} BGAEmotionTabBarButtonType;

@class BGAEmotionTabBar;

@protocol BGAEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(BGAEmotionTabBar *)tabBar didSelectButton:(BGAEmotionTabBarButtonType)buttonType;
@end

@interface BGAEmotionTabBar : UIView

@property (nonatomic, weak) id<BGAEmotionTabBarDelegate> delegate;

@end