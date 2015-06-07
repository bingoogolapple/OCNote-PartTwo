//
//  BGAStatusCell.m
//  WeiBo
//
//  Created by bingoogol on 15/6/7.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAStatusCell.h"
#import "BGAUser.h"
#import "BGAStatus.h"
#import "UIImageView+WebCache.h"
#import "BGAStatusFrame.h"

@interface BGAStatusCell()

// 原创微博
/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation BGAStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"statuses";
    BGAStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BGAStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /** 原创微博整体 */
        UIView *originalView = [[UIView alloc] init];
        [self.contentView addSubview:originalView];
        self.originalView = originalView;
        /** 头像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [originalView addSubview:iconView];
        self.iconView = iconView;
        /** 会员图标 */
        UIImageView *vipView = [[UIImageView alloc] init];
        [originalView addSubview:vipView];
        self.vipView = vipView;
        /** 配图 */
        UIImageView *photoView = [[UIImageView alloc] init];
        [originalView addSubview:photoView];
        self.photoView = photoView;
        /** 昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        [originalView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        /** 时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        [originalView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        /** 来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        [originalView addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        /** 正文 */
        UILabel *contentLabel = [[UILabel alloc] init];
        [originalView addSubview:contentLabel];
        self.contentLabel = contentLabel;
    }
    return self;
}

- (void)setStatusFrame:(BGAStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    BGAStatus *status = statusFrame.status;
    BGAUser *user = status.user;

    /** 原创微博整体 */
    self.originalView.frame = statusFrame.originalViewFrame;
    /** 头像 */
    self.iconView.frame = statusFrame.iconViewFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    /** 会员图标 */
    self.vipView.frame = statusFrame.vipViewFrame;
    self.vipView.image = [UIImage imageNamed:@"common_icon_membership_level1"];
    /** 配图 */
    self.photoView.frame = statusFrame.photoViewFrame;
    self.photoView.backgroundColor = [UIColor redColor];
    /** 昵称 */
    self.nameLabel.frame = statusFrame.nameLabelFrame;
    self.nameLabel.text = user.name;
    /** 时间 */
    self.timeLabel.frame = statusFrame.timeLabelFrame;
    /** 来源 */
    self.sourceLabel.frame = statusFrame.sourceLabelFrame;
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelFrame;
    self.contentLabel.text = statusFrame.status.text;
}

@end
