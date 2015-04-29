//
//  BGAScoreNoticeViewController.m
//  Lottery
//
//  Created by bingoogol on 15/4/29.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAScoreNoticeViewController.h"
#import "BGASettingSwitchItem.h"
#import "BGASettingGroup.h"
#import "BGASettingLabelItem.h"
#import "BGASaveTool.h"

@interface BGAScoreNoticeViewController ()

@property (nonatomic, strong) BGASettingLabelItem *startItem;

@end

@implementation BGAScoreNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup0];
    [self addGroup1];
    [self addGroup2];
}

- (void)addGroup0 {
    BGASettingSwitchItem *notice = [BGASettingSwitchItem itemWithIcon:nil title:@"提醒我关注比赛"];
    BGASettingGroup *group = [[BGASettingGroup alloc] init];
    group.footer = @"当我关注的比赛比分发生变化时，通过小弹窗或推送进行提醒";
    group.items = @[notice];
    [self.dataList addObject:group];
}

- (void)addGroup1 {
    BGASettingLabelItem *start = [BGASettingLabelItem itemWithIcon:nil title:@"开始时间"];
    
    if (!start.text.length) {
        start.text = @"00:00";
    }
    start.option = ^ {
        UITextField *textField = [[UITextField alloc] init];
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeTime;
        datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm";
        datePicker.date = [dateFormatter dateFromString:self.startItem.text];
        [datePicker addTarget:self action:@selector(dateValueChange:) forControlEvents:UIControlEventValueChanged];
        textField.inputView = datePicker;
        
        [self.view addSubview:textField];
        [textField becomeFirstResponder];
        
    };
    self.startItem = start;
    BGASettingGroup *group = [[BGASettingGroup alloc] init];
    group.header = @"只在一下时间接受比分直播";
    group.items = @[start];
    [self.dataList addObject:group];
}

- (void)addGroup2 {
    BGASettingLabelItem *stop = [BGASettingLabelItem itemWithIcon:nil title:@"结束时间"];
    stop.text = @"00:00";
    BGASettingGroup *group = [[BGASettingGroup alloc] init];
    group.items = @[stop];
    [self.dataList addObject:group];
}

- (void)dateValueChange:(UIDatePicker *)datePicker {
    Logger(@"%@", datePicker.date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    _startItem.text = [dateFormatter stringFromDate:datePicker.date];
    [self.tableView reloadData];
}

@end