//
//  BGATabBar.h
//  Lottery
//
//  Created by bingoogol on 15/4/22.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>
// block作用：保存一段代码，到恰当的时候再去调用
//typedef void(^BGATabBarBlock)(int selectedIndex);

@class BGATabBar;

@protocol BGATabBarDelegate <NSObject>

@optional
- (void)tabBar:(BGATabBar *)tabBar didSelectedIndex:(int)index;

@end

@interface BGATabBar : UITabBar

//@property (nonatomic, copy) BGATabBarBlock block;
@property (nonatomic, weak) id<BGATabBarDelegate> delegate;

@end