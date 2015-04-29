//
//  BGAPushViewController.m
//  Lottery
//
//  Created by bingoogol on 15/4/29.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAPushViewController.h"
#import "BGASettingArrowItem.h"
#import "BGASettingGroup.h"
#import "BGATestController.h"
#import "BGASettingCell.h"

@interface BGAPushViewController ()
@end

@implementation BGAPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup0];
}

- (void)addGroup0 {
    BGASettingArrowItem *push = [BGASettingArrowItem itemWithIcon:nil title:@"开奖号码推送" destVcClass:[BGATestController class]];
    BGASettingArrowItem *anim = [BGASettingArrowItem itemWithIcon:nil title:@"中奖动画" destVcClass:[BGATestController class]];
    BGASettingArrowItem *score = [BGASettingArrowItem itemWithIcon:nil title:@"比分直播提醒" destVcClass:[BGATestController class]];
    BGASettingArrowItem *timer = [BGASettingArrowItem itemWithIcon:nil title:@"购彩限时提醒" destVcClass:[BGATestController class]];
    BGASettingGroup *group0 = [[BGASettingGroup alloc] init];
    group0.items = @[push, anim, score, timer];
    [self.dataList addObject:group0];
}

@end
