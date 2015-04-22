//
//  BGATabBarController.m
//  Lottery
//
//  Created by bingoogol on 15/4/22.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGATabBarController.h"
#import "BGATabBar.h"

@interface BGATabBarController ()<BGATabBarDelegate>

@end

@implementation BGATabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 移除自带的tabBar
    [self.tabBar removeFromSuperview];
    BGATabBar *tabBar = [[BGATabBar alloc] init];
//    tabBar.block = ^(int selectedIndex) {
//        self.selectedIndex = selectedIndex;
//    };
    tabBar.delegate = self;
    tabBar.frame = self.tabBar.frame;
    [self.view addSubview:tabBar];
}

- (void)tabBar:(BGATabBar *)tabBar didSelectedIndex:(int)index {
    self.selectedIndex = index;
}

@end