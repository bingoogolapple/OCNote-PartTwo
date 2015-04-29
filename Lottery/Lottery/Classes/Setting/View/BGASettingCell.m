//
//  BGASettingCell.m
//  Lottery
//
//  Created by bingoogol on 15/4/26.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGASettingCell.h"
#import "BGASettingItem.h"
#import "BGASettingArrowItem.h"
#import "BGASettingSwitchItem.h"

@interface BGASettingCell()

@property (nonatomic, strong) UISwitch *switchAccessoryView;
@property (nonatomic, strong) UIImageView *imageAccessoryView;


@end

@implementation BGASettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SETTING_ITEM_CELL";
    BGASettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BGASettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (UISwitch *)switchAccessoryView {
    if (_switchAccessoryView == nil) {
        _switchAccessoryView = [[UISwitch alloc] init];
    }
    return _switchAccessoryView;
}

- (UIImageView *)imageAccessoryView {
    if (_imageAccessoryView == nil) {
        _imageAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _imageAccessoryView;
}

- (void)setItem:(BGASettingItem *)item {
    _item = item;
    Logger(@"%@", item.class);
    [self setupData];
    [self setupAccessoryView];
}

// 设置cell的子控件的数据
- (void)setupData {
    self.textLabel.text = _item.title;
    if (_item.icon.length) {
        self.imageView.image = [UIImage imageNamed:_item.icon];
    }
}

// 设置右边视图
- (void)setupAccessoryView {
    if ([_item isKindOfClass:[BGASettingArrowItem class]]) {
        self.accessoryView = self.imageAccessoryView;
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else if ([_item isKindOfClass:[BGASettingSwitchItem class]]) {
        // self.accessoryView = _switchAccessoryView;
        // 用了懒加载的，不能用下划线，必须用self.
        self.accessoryView = self.switchAccessoryView;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        self.accessoryView = nil;
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}


@end
