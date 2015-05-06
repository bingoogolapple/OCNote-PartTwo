//
//  BGATabBar.h
//  WeiBo
//
//  Created by bingoogol on 15/5/6.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BGATabBar;

// 因为BGATabBar继承自UITabBar，所以成为BGATabBar的代理，也必须实现UITabBar的代理协议
@protocol BGATabBarDelegate <UITabBarDelegate>

- (void)tabBarOnClickPlusBtn:(BGATabBar *)tabBar;

@end

@interface BGATabBar : UITabBar

@property (nonatomic, weak) id<BGATabBarDelegate> delegate;

@end
