//
//  BGASettingCell.h
//  Lottery
//
//  Created by bingoogol on 15/4/26.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BGASettingItem;

@interface BGASettingCell : UITableViewCell

@property (nonatomic, strong) BGASettingItem *item;
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end