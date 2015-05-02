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
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation BGAAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup0];
    
    self.tableView.tableHeaderView = [BGAAboutHeaderView headerView];
}

- (UIWebView *)webView {
    if (_webView == nil) {
        // 拨号之前会弹框询问用户是否拨号，拨完后能自动回到原程序
        // 这个webView千万不要设置尺寸，不然会挡住其他界面，他只是用来打电话，不需要显示
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}

- (void)addGroup0 {
    BGASettingArrowItem *score = [BGASettingArrowItem itemWithIcon:nil title:@"评分支持"];
    score.option = ^{
        NSString *appid = @"941028552";
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    };
    
    BGASettingArrowItem *tel = [BGASettingArrowItem itemWithIcon:nil title:@"客服电话"];
    tel.subTitle = @"020-83568090";
    tel.option = ^{
        // 不会提示用户是否打电话，ios8之前电话打完后，不会自动回到原应用，直接停留在通话记录界面
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://13693437945"]];
        // 会提示用户是否打电话
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://13693437945"]]];
    };
    
    BGASettingGroup *group0 = [[BGASettingGroup alloc] init];
    group0.items = @[score, tel];
    [self.dataList addObject:group0];
}

@end
