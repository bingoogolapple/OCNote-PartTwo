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
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    BGATest2ViewController *test2 = [[BGATest2ViewController alloc] init];
    test2.title = @"测试2控制器";
    [self.navigationController pushViewController:test2 animated:YES];
}

- (void)dealloc {
    Logger(@"%s", __func__);
}

@end
