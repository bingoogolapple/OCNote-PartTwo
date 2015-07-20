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
#import "BGAUser.h"
#import "BGAStatus.h"
#import "MJExtension.h"
#import "BGALoadMoreFooter.h"
#import "BGAStatusCell.h"
#import "BGAStatusFrame.h"
#import "BGAHttpTool.h"


@interface BGAHomeViewController ()<BGADropdownMenuDelegate>

@property (nonatomic, strong) NSMutableArray *statuseFrames;

@end

@implementation BGAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = BGAColor(211, 211, 211);
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 系统会在BGAStatusCellMargin的基础上再加上64。会导致下拉刷新的菊花也会往下移动BGAStatusCellMargin
//    self.tableView.contentInset = UIEdgeInsetsMake(BGAStatusCellMargin, 0, 0, 0);
    
    [self setupNavigationItem];
    
    [self setupUserInfo];
    
//    [self loadNewStatus];
    
    [self setupRefresh];
    
    [self setupLoadMore];
    
//    // 获得未读数
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
//    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  获得未读数
 */
- (void)setupUnreadCount {
    Logger(@"setupUnreadCount");
    
    // 2.拼接请求参数
    BGAAccount *account = [BGAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [BGAHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:params success:^(id json) {
        // description转成字符串
        NSString *status = [json[@"status"] description];
        // 如果是0，得清空数字
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else {
            // 非0情况
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(NSError *error) {
        Logger(@"请求失败-%@", error);
    }];
}

- (void)setupLoadMore {
    BGALoadMoreFooter *footer = [BGALoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
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

    BGAAccount *account = [BGAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    BGAStatusFrame *firstStatusFrame = [self.statuseFrames firstObject];
    if (firstStatusFrame) {
        params[@"since_id"] = firstStatusFrame.status.idstr;
    }
    
    [BGAHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        [control endRefreshing];
        Logger(@"加载最新状态成功 - %@", json);
        NSArray *newStatuses = [BGAStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        NSArray *newStatusFrames = [self statusFramesWithStatuses:newStatuses];
        
        NSRange range = NSMakeRange(0, newStatusFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [self.statuseFrames insertObjects:newStatusFrames atIndexes:set];
        
        [self.tableView reloadData];
        
        [self showNewStatusCount:newStatuses.count];
    } failure:^(NSError *error) {
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

- (NSMutableArray *)statuseFrames {
    if (!_statuseFrames) {
        _statuseFrames = [NSMutableArray array];
    }
    return _statuseFrames;
}

- (void)loadNewStatus {
    BGAAccount *account = [BGAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
//    params[@"count"] = @7;
    
    [BGAHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        Logger(@"加载最新状态成功 - %@", json);
        NSArray *newStatuses = [BGAStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        [self.statuseFrames addObjectsFromArray:newStatuses];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
         Logger(@"加载最新状态失败 - %@", error);
    }];
}

- (void)setupUserInfo {
    // https://api.weibo.com/2/users/show.json
    // access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    // uid	false	int64	需要查询的用户ID。
    
    BGAAccount *account = [BGAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [BGAHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id json) {
        Logger(@"获取用户信息成功 - %@", json);
        
        BGAUser *user = [BGAUser objectWithKeyValues:json];
        account.name = user.name;
        [BGAAccountTool saveAccount:account];
        
        BGATitleButton *titleButton = (BGATitleButton *)self.navigationItem.titleView;
        [titleButton setTitle:account.name forState:UIControlStateNormal];
    } failure:^(NSError *error) {
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
    return self.statuseFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BGAStatusCell *cell = [BGAStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statuseFrames[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BGAStatusFrame *statusFrame = self.statuseFrames[indexPath.row];
    return statusFrame.cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    // 如果tableView还没有数据，就直接返回
    if (self.statuseFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) {
        return;
    }
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    // 最后一个cell完全进入视野范围内
    if (offsetY >= judgeOffsetY) {
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        Logger(@"加载更多的微博数据");
        [self loadMoreStatus];
    }
    
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus {

    BGAAccount *account = [BGAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    BGAStatusFrame *lastStatusFrame = [self.statuseFrames lastObject];
    if (lastStatusFrame) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusFrame.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    [BGAHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [BGAStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        NSArray *newStatusFrames = [self statusFramesWithStatuses:newStatuses];
        // 将更多的微博数据，添加到总数组的最后面
        [self.statuseFrames addObjectsFromArray:newStatusFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(NSError *error) {
        Logger(@"请求失败-%@", error);
        
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}

- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses {
    NSMutableArray *statusFrames = [NSMutableArray array];
    for (BGAStatus *status in statuses) {
        BGAStatusFrame *statusFrame = [[BGAStatusFrame alloc] init];
        statusFrame.status = status;
        [statusFrames addObject:statusFrame];
    }
    return statusFrames;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Logger(@"didSelectRowAtIndexPath---%d", indexPath.row);
}

@end
