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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end