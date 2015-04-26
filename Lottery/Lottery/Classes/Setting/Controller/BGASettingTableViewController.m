//
//  BGASettingTableViewController.m
//  Lottery
//
//  Created by iqeggandroid on 15/4/26.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGASettingTableViewController.h"

@interface BGASettingTableViewController ()

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end