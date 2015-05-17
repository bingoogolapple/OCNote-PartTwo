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
#import "AFNetworking.h"
#import "BGAAccountTool.h"


@interface BGAHomeViewController ()<BGADropdownMenuDelegate>

@end

@implementation BGAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
    
    [self setupUserInfo];
}

- (void)setupUserInfo {
    // https://api.weibo.com/2/users/show.json
    // access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    // uid	false	int64	需要查询的用户ID。
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 默认的序列化器就是json
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    BGAAccount *account = [BGAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        Logger(@"请求成功 - %@", responseObject);
        
        NSString *name = responseObject[@"name"];
        account.name = name;
        [BGAAccountTool saveAccount:account];
        
        BGATitleButton *titleButton = (BGATitleButton *)self.navigationItem.titleView;
        [titleButton setTitle:name forState:UIControlStateNormal];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        Logger(@"请求失败 - %@", error);
    }];
}

- (void)setupNavigationItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    
    BGATitleButton *titleButton = [BGATitleButton buttonWithType:UIButtonTypeCustom];
    NSString *name = [BGAAccountTool account].name;
    [titleButton setTitle:name? name : @"首页" forState:UIControlStateNormal];
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
