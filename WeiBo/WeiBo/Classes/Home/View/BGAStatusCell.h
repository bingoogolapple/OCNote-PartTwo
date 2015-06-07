//
//  BGAStatusCell.h
//  WeiBo
//
//  Created by bingoogol on 15/6/7.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BGAStatusFrame;

@interface BGAStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) BGAStatusFrame *statusFrame;

@end