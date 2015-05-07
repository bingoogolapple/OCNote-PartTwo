//
//  BGAHomeViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/5/3.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAHomeViewController.h"
#import "BGATitleButton.h"
#import "BGADropdownMenu.h"
#import "BGAHomeTitleViewController.h"

@interface BGAHomeViewController ()<BGADropdownMenuDelegate>

@end

@implementation BGAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
    
    UIView *grayView = [[UIView alloc] init];
    grayView.width = 200;
    grayView.height = 70;
    grayView.x = 20;
    grayView.y = 30;
    grayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:grayView];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.width = 100;
    btn.x = 140;
    btn.y = 30;
    btn.height = 30;
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(onClickTitle:) forControlEvents:UIControlEventTouchUpInside];
    [grayView addSubview:btn];
}

- (void)setupNavigationItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    BGATitleButton *titleButton = [BGATitleButton buttonWithType:UIButtonTypeCustom];
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    // 如果只涉及到两张时，一开始写好图片，接下来只要设置selected
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    titleButton.backgroundColor = BGARandomColor;
    titleButton.width = 150;
    titleButton.height = 30;
    
    [titleButton addTarget:self action:@selector(onClickTitle:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

- (void)onClickTitle:(UIButton *)titleButton {
    BGADropdownMenu *dropdownMenu = [BGADropdownMenu menu];
    dropdownMenu.delegate = self;
//    dropdownMenu.content = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    BGAHomeTitleViewController *vc = [[BGAHomeTitleViewController alloc] init];
    vc.view.height = 150;
    vc.view.width = 150;
    dropdownMenu.contentController = vc;
    
    [dropdownMenu showFrom:titleButton];
}

- (void)friendSearch {
    Logger(@"friendSearch");
}

- (void)pop {
    Logger(@"pop");
}

- (void)onDropdownMenuDismiss:(BGADropdownMenu *)menu {
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
//    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleButton.selected = NO;
}

- (void)onDropdownMenuShow:(BGADropdownMenu *)menu {
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
//    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    titleButton.selected = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
