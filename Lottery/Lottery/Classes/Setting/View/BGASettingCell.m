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
#import "BGASettingLabelItem.h"

@interface BGASettingCell()

@property (nonatomic, strong) UISwitch *switchAccessoryView;
@property (nonatomic, strong) UIImageView *imageAccessoryView;
@property (nonatomic, strong) UILabel *labelAccessoryView;
@property (nonatomic, strong) UIView *divider;

@end

@implementation BGASettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SETTING_ITEM_CELL";
    BGASettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BGASettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupBg];
        [self setupSubviewsBg];
    }
    return self;
}

- (void)setupBg {
    self.backgroundColor = [UIColor whiteColor];
    // 取消ios6的圆角，ios6的分割线和圆角都在backgroundView,ios7的分割线不在backgroundView中
    UIView *backgroundView = [[UIView alloc] init];
    self.backgroundView = backgroundView;
    
    // 设置选中时的背景
    UIView *selectedBg = [[UIView alloc] init];
    selectedBg.backgroundColor = BGAColor(237, 233, 218);
    self.selectedBackgroundView = selectedBg;
}

- (void)setupSubviewsBg {
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
}

- (void)setFrame:(CGRect)frame {
    frame.size.width += 20;
    frame.origin.x -= 10;
    [super setFrame:frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    Logger(@"%@", NSStringFromCGRect(self.contentView.frame));
    
    CGFloat dividerX = self.textLabel.frame.origin.x;
    CGFloat dividerY = 0;
    CGFloat dividerW = self.contentView.bounds.size.width;
    CGFloat dividerH = 1;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    self.divider.hidden = indexPath.row == 0;
}

- (UIView *)divider {
    if (_divider == nil) {
        if (!ios7) {
            UIView *divider = [[UIView alloc] init];
            divider.backgroundColor = [UIColor blackColor];
            divider.alpha = 0.2;
            [self.contentView addSubview:divider];
            
            _divider = divider;
        }
    }
    return _divider;
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

- (UILabel *)labelAccessoryView {
    if (_labelAccessoryView == nil) {
        _labelAccessoryView = [[UILabel alloc] init];
        _labelAccessoryView.bounds = CGRectMake(0, 0, 100, 44);
        _labelAccessoryView.textAlignment = NSTextAlignmentRight;
        _labelAccessoryView.textColor = [UIColor redColor];
    }
    return _labelAccessoryView;
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
    self.detailTextLabel.text = _item.subTitle;
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
    } else if ([_item isKindOfClass:[BGASettingLabelItem class]]) {
        self.accessoryView = self.labelAccessoryView;
        BGASettingLabelItem *labelItem = (BGASettingLabelItem *)self.item;
        self.labelAccessoryView.text = labelItem.text;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        self.accessoryView = nil;
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}


@end
