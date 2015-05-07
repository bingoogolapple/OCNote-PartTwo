//
//  BGANavigationController.m
//  WeiBo
//
//  Created by bingoogol on 15/5/4.
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
        // 设置整个项目所有item的主题样式
//        UIBarButtonItem *item = [UIBarButtonItem appearance];
        UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:[BGANavigationController class], nil];
        
        // 设置普通状态
        // key：NS****AttributeName
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        // 设置不可用状态
        NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
        disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
        disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    }
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        
        // 设置右边的更多按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    // 这里要用self，不是self.navigationController,因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

- (void)more {
    [self popToRootViewControllerAnimated:YES];
}

@end