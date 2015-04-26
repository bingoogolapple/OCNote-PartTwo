//
//  BGANavigationController.m
//  Lottery
//
//  Created by bingoogol on 15/4/23.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGANavigationController.h"

@interface BGANavigationController ()

@end

@implementation BGANavigationController

// 第一次使用这个类或者这个类的子类的时候
+ (void)initialize {
    // 判断一下当前类是否是BGANavigationController，避免是在该类的子类调用
    if(self == [BGANavigationController class]) {
        Logger(@"%s", __func__);
        [self setupNav];
        
        // 如果是iOS7，不需要设置BarButton外观
        if (ios7) return;
        
        [self setupBarButton];
    }
}

/**
 *  设置全局BarButton外观
 */
+ (void)setupBarButton {
    // 获取所有的UIBarButton的外观
    UIBarButtonItem *buttonItem = [UIBarButtonItem appearance];
    
    [buttonItem setBackgroundImage:[UIImage imageNamed:@"NavButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [buttonItem setBackgroundImage:[UIImage imageNamed:@"NavButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    [buttonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"NavButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [buttonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

/**
 *  设置全局导航条外观
 */
+ (void)setupNav {
    // 获取应用程序中所有的导航条
    // 获取所有当行条外观
    UINavigationBar *navBar = [UINavigationBar appearance];
    // iOS6导航条高度44
    NSString *navImgName = nil;
    if(ios7) {
        Logger(@"iOS7及以上");
        navImgName = @"NavBar64";
    } else {
        Logger(@"iOS7以下");
        navImgName = @"NavBar";
    }
    [navBar setBackgroundImage:[UIImage imageNamed:navImgName] forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *textAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                     NSFontAttributeName : [UIFont systemFontOfSize:15]};
    [navBar setTitleTextAttributes:textAttributes];
    
    // 设置导航条的主题颜色
    [navBar setTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end