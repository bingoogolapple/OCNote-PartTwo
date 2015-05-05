//
//  BGADiscoverViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/5/3.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGADiscoverViewController.h"
#import "BGASearchBar.h"

@interface BGADiscoverViewController ()

@end

@implementation BGADiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BGASearchBar *searchBar = [BGASearchBar searchBar];
    searchBar.height = 30;
    searchBar.width = self.view.bounds.size.width;
    self.navigationItem.titleView = searchBar;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
