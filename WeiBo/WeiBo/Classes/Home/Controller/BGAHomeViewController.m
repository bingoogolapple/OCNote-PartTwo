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
#import "UIImageView+WebCache.h"
#import "BGAUser.h"
#import "BGAStatus.h"
#import "MJExtension.h"


@interface BGAHomeViewController ()<BGADropdownMenuDelegate>

@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation BGAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
    
    [self setupUserInfo];
    
//    [self loadNewStatus];
    
    [self setupRefresh];
}

- (void)setupRefresh {
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    // 只有用户手动下拉刷新才会触发UIControlEventValueChanged事件
    [control addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    // 马上进入刷新状态(仅仅是像是刷新状态，并不会触发UIControlEventValueChanged事件)
    [control beginRefreshing];
    
    [self refresh:control];
}

- (void)refresh:(UIRefreshControl *)control {
    Logger(@"下拉刷新");
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    BGAAccount *account = [BGAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    BGAStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        params[@"since_id"] = firstStatus.idstr;
    }
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [control endRefreshing];
        Logger(@"加载最新状态成功 - %@", responseObject);
        NSArray *newStatuses = [BGAStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [self.statuses insertObjects:newStatuses atIndexes:set];
        
        [self.tableView reloadData];
        
        [self showNewStatusCount:newStatuses.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [control endRefreshing];
        Logger(@"加载最新状态失败 - %@", error);
    }];
}

- (void)showNewStatusCount:(int)count {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 30;
     
    if (count == 0) {
        label.text = @"没有新的微博数据，稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据", count];
    }
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.y = 64 - label.height;
    
    // 将label添加到导航控制器的view中，并且是盖在导航栏下
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    CGFloat duration = 1.0;
    // 如果某个动画执行完毕后，又要回到动画执行前的状态，建议使用transform来做动画
    [UIView animateWithDuration:duration animations:^{
//        label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
//            label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

- (NSMutableArray *)statuses {
    if (!_statuses) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)loadNewStatus {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    BGAAccount *account = [BGAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
//    params[@"count"] = @7;
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        Logger(@"加载最新状态成功 - %@", responseObject);
        NSArray *newStatuses = [BGAStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        [self.statuses addObjectsFromArray:newStatuses];
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        Logger(@"加载最新状态失败 - %@", error);
    }];
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
        Logger(@"获取用户信息成功 - %@", responseObject);
        
        BGAUser *user = [BGAUser objectWithKeyValues:responseObject];
        account.name = user.name;
        [BGAAccountTool saveAccount:account];
        
        BGATitleButton *titleButton = (BGATitleButton *)self.navigationItem.titleView;
        [titleButton setTitle:account.name forState:UIControlStateNormal];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        Logger(@"获取用户信息失败 - %@", error);
    }];
}

- (void)setupNavigationItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    
    BGATitleButton *titleButton = [BGATitleButton buttonWithType:UIButtonTypeCustom];
    NSString *name = [BGAAccountTool account].name;
    [titleButton setTitle:name? name : @"首页" forState:UIControlStateNormal];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"statuses";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    BGAStatus *status = self.statuses[indexPath.row];
    
    BGAUser *user = status.user;
    cell.textLabel.text = user.name;
    
    cell.detailTextLabel.text = status.text;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    return cell;
}

@end
