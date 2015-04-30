//
//  BGAShareViewController.m
//  Lottery
//
//  Created by bingoogol on 15/4/30.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAShareViewController.h"
#import "BGASettingArrowItem.h"
#import "BGASettingGroup.h"

@interface BGAShareViewController ()

@end

@implementation BGAShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup0];
}

- (void)addGroup0 {
    BGASettingArrowItem *mail = [BGASettingArrowItem itemWithIcon:@"MailShare" title:@"邮件分享"];
    BGASettingArrowItem *sms = [BGASettingArrowItem itemWithIcon:@"SmsShare" title:@"短信分享"];
    BGASettingArrowItem *sina = [BGASettingArrowItem itemWithIcon:@"WeiboSina" title:@"新浪分享"];
    BGASettingGroup *group0 = [[BGASettingGroup alloc] init];
    group0.items = @[sina, sms, mail];
    [self.dataList addObject:group0];
}

@end
