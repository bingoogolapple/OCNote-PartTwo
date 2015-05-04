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

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        /* 设置导航栏上面的内容 */
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 设置图片
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        // 设置尺寸
        //    CGSize size = backBtn.currentBackgroundImage.size;
        // 这里的x,y无效
        //    backBtn.frame = CGRectMake(0, 0, size.width, size.height);
        backBtn.size = backBtn.currentBackgroundImage.size;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        // 设置图片
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        // 设置尺寸
        moreBtn.size = moreBtn.currentBackgroundImage.size;
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
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