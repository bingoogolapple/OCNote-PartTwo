//
//  BGAPublicViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/7/9.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAPublicViewController.h"
#import "BGAAccountTool.h"

@interface BGAPublicViewController()


@end


@implementation BGAPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
}

- (void)setupTextView {
    // UITextField只有一行
    // UITextView可以有多行
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:textView];
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    UILabel *titleView = [[UILabel alloc] init];
    // A value of 0 means no limit   这个一定要设置，否则不能换行
    titleView.numberOfLines = 0;
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.width = 200;
    titleView.height = 44;
    
    NSString *username = [BGAAccountTool account].name;
    NSString *prefix = @"发微博";
    NSString *title = [NSString stringWithFormat:@"%@\n%@", prefix, username];
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:title];
    [attrTitle addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[title rangeOfString:prefix]];
    [attrTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[title rangeOfString:username]];
    [attrTitle addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[title rangeOfString:username]];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor redColor];
    shadow.shadowOffset = CGSizeMake(2, 2);
    [attrTitle addAttribute:NSShadowAttributeName value:shadow range:[title rangeOfString:prefix]];
    
    titleView.attributedText = attrTitle;
    self.navigationItem.titleView = titleView;
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    
}

@end
