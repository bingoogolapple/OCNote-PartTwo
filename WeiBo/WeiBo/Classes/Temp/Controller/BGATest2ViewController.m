//
//  BGATest2ViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/5/3.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGATest2ViewController.h"
#import "BGATest3ViewController.h"

@interface BGATest2ViewController ()

@end

@implementation BGATest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    BGATest3ViewController *test3 = [[BGATest3ViewController alloc] init];
    test3.title = @"测试3控制器";
    [self.navigationController pushViewController:test3 animated:YES];
}

- (void)dealloc {
    Logger(@"%s", __func__);
}

@end
