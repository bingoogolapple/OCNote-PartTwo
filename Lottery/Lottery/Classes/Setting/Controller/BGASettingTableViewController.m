//
//  BGASettingTableViewController.m
//  Lottery
//
//  Created by iqeggandroid on 15/4/26.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGASettingTableViewController.h"
#import "BGASettingItem.h"
#import "BGASettingGroup.h"
#import "BGASettingCell.h"
#import "BGASettingArrowItem.h"
#import "BGASettingSwitchItem.h"
#import "BGATestController.h"

@interface BGASettingTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation BGASettingTableViewController

- (instancetype)init {
//    self = [super initWithStyle:UITableViewStyleGrouped];
//    if (self) {
//        
//    }
//    return self;
    
    // 不需要初始化控制器中的属性，直接用下面这一句
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSMutableArray *)dataList {
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
        
        BGASettingArrowItem *pushNotice = [BGASettingArrowItem itemWithIcon:@"MorePush" title:@"推送和提醒" destVcClass:[BGATestController class]];

        BGASettingItem *yaoYiYao = [BGASettingSwitchItem itemWithIcon:@"handShake" title:@"摇一摇机选"];
        BGASettingGroup *group0 = [[BGASettingGroup alloc] init];
        group0.items = @[pushNotice, yaoYiYao];
        group0.header = @"group0header";
        group0.footer = @"group0footer";
        
        BGASettingItem *checkNewVersion = [BGASettingArrowItem itemWithIcon:@"MoreUpdate" title:@"检查新版本"];
        BGASettingItem *help = [BGASettingArrowItem itemWithIcon:@"MoreHelp" title:@"帮助"];
        BGASettingGroup *group1 = [[BGASettingGroup alloc] init];
        group1.items = @[checkNewVersion, help];
        group1.header = @"group0header";
        group1.footer = @"group0footer";
        
        [_dataList addObject:group0];
        [_dataList addObject:group1];
    }
    return _dataList;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BGASettingGroup *group = self.dataList[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    BGASettingCell *cell = [BGASettingCell cellWithTableView:tableView];
    // 取出模型
    BGASettingGroup *group = self.dataList[indexPath.section];
    BGASettingItem *item = group.items[indexPath.row];
    // 传递模型
    cell.item = item;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    BGASettingGroup *group = self.dataList[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    BGASettingGroup *group = self.dataList[section];
    return group.footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BGASettingGroup *group = self.dataList[indexPath.section];
    BGASettingItem *item = group.items[indexPath.row];
    if ([item isKindOfClass:[BGASettingArrowItem class]]) {
        BGASettingArrowItem *arrowItem = (BGASettingArrowItem *)item;
        if (arrowItem.destVcClass) {
            // 通过字符串创建，不推荐用这种方式，编译时不会报警告
            // Class vcClass = NSClassFromString(@"");
            UIViewController *vc = [[arrowItem.destVcClass alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

@end