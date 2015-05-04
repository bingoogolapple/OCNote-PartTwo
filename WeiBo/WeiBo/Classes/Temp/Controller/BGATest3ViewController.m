//
//  BGATest3ViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/5/3.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGATest3ViewController.h"

@interface BGATest3ViewController ()

@end

@implementation BGATest3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试" style:0 target:nil action:nil];
}

- (void)dealloc {
    Logger(@"%s", __func__);
}

@end
