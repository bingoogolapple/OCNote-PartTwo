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
#import "MBProgressHUD+MJ.h"
#import "BGAProductViewController.h"

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
        BGASettingItem *handShake = [BGASettingSwitchItem itemWithIcon:@"handShake" title:@"摇一摇机选"];
        BGASettingItem *soundEffect = [BGASettingSwitchItem itemWithIcon:@"sound_Effect" title:@"声音效果"];
        BGASettingGroup *group0 = [[BGASettingGroup alloc] init];
        group0.items = @[pushNotice, handShake, soundEffect];
        group0.header = @"group0header";
        group0.footer = @"group0footer";
        
        BGASettingItem *checkNewVersion = [BGASettingArrowItem itemWithIcon:@"MoreUpdate" title:@"检查新版本"];
        checkNewVersion.option = ^{
            [MBProgressHUD showMessage:@"正在检查新版本"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"有新版本" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"立即更新", nil];
                [alert show];
            });
        };
        BGASettingItem *help = [BGASettingArrowItem itemWithIcon:@"MoreHelp" title:@"帮助"];
        BGASettingItem *share = [BGASettingArrowItem itemWithIcon:@"MoreShare" title:@"分享"];
        BGASettingItem *message = [BGASettingArrowItem itemWithIcon:@"MoreMessage" title:@"查看消息"];
        BGASettingItem *netease = [BGASettingArrowItem itemWithIcon:@"MoreNetease" title:@"产品推荐" destVcClass:[BGAProductViewController class]];
        BGASettingItem *about = [BGASettingArrowItem itemWithIcon:@"MoreAbout" title:@"关于"];
        BGASettingGroup *group1 = [[BGASettingGroup alloc] init];
        group1.items = @[checkNewVersion, help, share, message, netease, about];
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
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

@end