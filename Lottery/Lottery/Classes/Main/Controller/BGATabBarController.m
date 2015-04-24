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
    
    BGATabBar *tabBar = [[BGATabBar alloc] init];
//    tabBar.block = ^(int selectedIndex) {
//        self.selectedIndex = selectedIndex;
//    };
    tabBar.delegate = self;
    
    // 移除自带的tabBar
//    [self.tabBar removeFromSuperview];
//    tabBar.frame = self.tabBar.frame;
//    [self.view addSubview:tabBar];
    // 因为系统自动隐藏的是系统自带的tabBar
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    
    NSString *imgName = nil;
    NSString *selectedImgName = nil;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        imgName = [NSString stringWithFormat:@"TabBar%d", i + 1];
        selectedImgName = [NSString stringWithFormat:@"TabBar%dSel", i + 1];
        [tabBar addTabBarButtonWithImgName:imgName selectedImgName:selectedImgName];
    }
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)tabBar:(BGATabBar *)tabBar didSelectedIndex:(int)index {
    self.selectedIndex = index;
}

@end