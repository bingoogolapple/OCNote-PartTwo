//
//  BGAPublicViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/7/9.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAPublicViewController.h"

@interface BGAPublicViewController()


@end


@implementation BGAPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    
}

@end
