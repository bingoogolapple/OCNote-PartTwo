//
//  BGAAboutViewController.m
//  Lottery
//
//  Created by bingoogol on 15/4/30.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAAboutViewController.h"
#import "BGASettingArrowItem.h"
#import "BGASettingGroup.h"
#import "BGAAboutHeaderView.h"

@interface BGAAboutViewController ()

@end

@implementation BGAAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup0];
    
    self.tableView.tableHeaderView = [BGAAboutHeaderView headerView];
}

- (void)addGroup0 {
    BGASettingArrowItem *score = [BGASettingArrowItem itemWithIcon:nil title:@"评分支持"];
    BGASettingArrowItem *tel = [BGASettingArrowItem itemWithIcon:nil title:@"客服电话"];
    tel.subTitle = @"020-83568090";
    BGASettingGroup *group0 = [[BGASettingGroup alloc] init];
    group0.items = @[score, tel];
    [self.dataList addObject:group0];
}

@end
