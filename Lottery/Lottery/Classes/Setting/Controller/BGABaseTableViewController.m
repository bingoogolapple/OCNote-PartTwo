//
//  BGABaseTableViewController.m
//  Lottery
//
//  Created by bingoogol on 15/4/29.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGABaseTableViewController.h"
#import "BGASettingItem.h"
#import "BGASettingGroup.h"
#import "BGASettingCell.h"
#import "BGASettingArrowItem.h"
#import "BGASettingSwitchItem.h"

@interface BGABaseTableViewController ()
@end

@implementation BGABaseTableViewController

- (instancetype)init {
    //    self = [super initWithStyle:UITableViewStyleGrouped];
    //    if (self) {
    //
    //    }
    //    return self;
    
    // 不需要初始化控制器中的属性，直接用下面这一句
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)dataList {
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
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
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BGASettingGroup *group = self.dataList[indexPath.section];
    BGASettingItem *item = group.items[indexPath.row];
    
    // 执行item点击操作
    if (item.option) {
        item.option();
        return;
    }
    
    if ([item isKindOfClass:[BGASettingArrowItem class]]) {
        BGASettingArrowItem *arrowItem = (BGASettingArrowItem *)item;
        if (arrowItem.destVcClass) {
            // 通过字符串创建，不推荐用这种方式，编译时不会报警告
            // Class vcClass = NSClassFromString(@"");
            UIViewController *vc = [[arrowItem.destVcClass alloc] init];
            vc.title = arrowItem.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

@end
