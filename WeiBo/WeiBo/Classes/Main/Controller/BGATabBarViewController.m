//
//  BGATabBarViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/5/3.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGATabBarViewController.h"
#import "BGAHomeViewController.h"
#import "BGAMessageCenterViewController.h"
#import "BGADiscoverViewController.h"
#import "BGAProfileViewController.h"
#import "BGANavigationController.h"
#import "BGATabBar.h"

@interface BGATabBarViewController ()<BGATabBarDelegate>

@end

@implementation BGATabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initChildVc];
}

- (void)initChildVc {
    BGAHomeViewController *home = [[BGAHomeViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    BGAMessageCenterViewController *messageCenter = [[BGAMessageCenterViewController alloc] init];
    [self addChildVc:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    BGADiscoverViewController *discover = [[BGADiscoverViewController alloc] init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    BGAProfileViewController *profile = [[BGAProfileViewController alloc] init];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
//    self.tabBar = [[BGATabBar alloc] init];
    // tabBar为只读属性，只能用kvc设置
    BGATabBar *tabBar = [[BGATabBar alloc] init];
    tabBar.delegate = self;
    // [self setValue:tabBar forKey:@"tabBar"];
    // forKeyPath包含了forKey的功能，以后使用forKeyPath就可以了
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    // 设置tabbar的文字
//    childVc.tabBarItem.title = title;
    // 设置navgationbar的文字
//    childVc.navigationItem.title = title;
    // 同时设置tabbar和navgationbar的文字
    childVc.title = title;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = BGAColor(123,123,123);
    [childVc.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    NSMutableDictionary *selAttrs = [NSMutableDictionary dictionary];
    selAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selAttrs forState:UIControlStateSelected];
    
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 声明这张图片按照原始的样子显示，不要自动渲染成其他颜色
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 如果这里设置了子控制器的颜色，会导致一下子创建4个子控制器的View
//    childVc.view.backgroundColor = BGARandomColor;
    
    
    BGANavigationController *nav = [[BGANavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

- (void)tabBarOnClickPlusBtn:(BGATabBar *)tabBar {
    Logger(@"点击了加号按钮");
}

@end