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
#import "BGAPushViewController.h"
#import "BGAHelpViewController.h"
#import "BGAShareViewController.h"
#import "BGAAboutViewController.h"

@interface BGASettingTableViewController ()
@end

@implementation BGASettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addGroup0];
    [self addGroup1];
}

- (void)addGroup0 {
    BGASettingArrowItem *pushNotice = [BGASettingArrowItem itemWithIcon:@"MorePush" title:@"推送和提醒" destVcClass:[BGAPushViewController class]];
    BGASettingItem *handShake = [BGASettingSwitchItem itemWithIcon:@"handShake" title:@"摇一摇机选"];
    BGASettingItem *soundEffect = [BGASettingSwitchItem itemWithIcon:@"sound_Effect" title:@"声音效果"];
    BGASettingGroup *group0 = [[BGASettingGroup alloc] init];
    group0.items = @[pushNotice, handShake, soundEffect];
    group0.header = @"group0header";
    group0.footer = @"group0footer";
    [self.dataList addObject:group0];
}

- (void)addGroup1 {
    BGASettingItem *checkNewVersion = [BGASettingArrowItem itemWithIcon:@"MoreUpdate" title:@"检查新版本"];
    checkNewVersion.option = ^{
        [MBProgressHUD showMessage:@"正在检查新版本"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"有新版本" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"立即更新", nil];
            [alert show];
        });
    };
    BGASettingItem *help = [BGASettingArrowItem itemWithIcon:@"MoreHelp" title:@"帮助" destVcClass:[BGAHelpViewController class]];
    BGASettingItem *share = [BGASettingArrowItem itemWithIcon:@"MoreShare" title:@"分享" destVcClass:[BGAShareViewController class]];
    BGASettingItem *message = [BGASettingArrowItem itemWithIcon:@"MoreMessage" title:@"查看消息"];
    BGASettingItem *netease = [BGASettingArrowItem itemWithIcon:@"MoreNetease" title:@"产品推荐" destVcClass:[BGAProductViewController class]];
    BGASettingItem *about = [BGASettingArrowItem itemWithIcon:@"MoreAbout" title:@"关于" destVcClass:[BGAAboutViewController class]];
    BGASettingGroup *group1 = [[BGASettingGroup alloc] init];
    group1.items = @[checkNewVersion, help, share, message, netease, about];
    group1.header = @"group0header";
    group1.footer = @"group0footer";
    [self.dataList addObject:group1];
}


@end