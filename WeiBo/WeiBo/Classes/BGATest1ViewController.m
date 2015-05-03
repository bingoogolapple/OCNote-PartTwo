//
//  BGATest1ViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/5/3.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGATest1ViewController.h"
#import "BGATest2ViewController.h"

@interface BGATest1ViewController ()

@end

@implementation BGATest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
//    CGSize size = backBtn.currentBackgroundImage.size;
    // 这里的x,y无效
//    backBtn.frame = CGRectMake(0, 0, size.width, size.height);
    
    backBtn.size = backBtn.currentBackgroundImage.size;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
    moreBtn.size = moreBtn.currentBackgroundImage.size;
    [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)more {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    BGATest2ViewController *test2 = [[BGATest2ViewController alloc] init];
    test2.title = @"测试2控制器";
    [self.navigationController pushViewController:test2 animated:YES];
}

@end
