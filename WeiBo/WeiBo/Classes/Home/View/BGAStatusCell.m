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
#import "BGAPhoto.h"
#import "BGAStatusToolbar.h"
#import "BGAStatusPhotosView.h"

@interface BGAStatusCell()

// 原创微博
/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) BGAStatusPhotosView *photosView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;


// 转发微博
/** 转发微博整体 */
@property (nonatomic, weak) UIView *retweetView;
/** 转发微博正文+昵称 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发微博配图 */
@property (nonatomic, weak) BGAStatusPhotosView *retweetPhotosView;

// 工具条
/** 工具条整体 */
@property (nonatomic, weak) BGAStatusToolbar *toolbarView;

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
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 设置选中时的背景颜色。注意：selectionStyle要使用默认的值
//        UIView *backgroundView = [[UIView alloc] init];
//        backgroundView.backgroundColor = [UIColor redColor];
//        self.selectedBackgroundView = backgroundView;
        // 这种做法不生效
//        self.selectedBackgroundView.backgroundColor = [UIColor redColor];
        
        [self setupOriginal];
        [self setupRetweet];
        [self setupToolbar];
    }
    return self;
}

- (void)setupOriginal {
    /** 原创微博整体 */
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    originalView.backgroundColor = [UIColor whiteColor];
    self.originalView = originalView;
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = BGAStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = BGAStatusCellTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = BGAStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = BGAStatusCellContentFont;
    // A value of 0 means no limit
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    /** 配图 */
    BGAStatusPhotosView *photosView = [[BGAStatusPhotosView alloc] init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
}

- (void)setupRetweet {
    /** 转发微博整体 */
    UIView *retweetView = [[UIView alloc] init];
    [self.contentView addSubview:retweetView];
    retweetView.backgroundColor = BGAColor(247, 247, 247);
    self.retweetView = retweetView;
    
    /** 转发微博正文+昵称 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.font = BGARetweetStatusCellContentFont;
    // A value of 0 means no limit
    retweetContentLabel.numberOfLines = 0;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发微博配图 */
    BGAStatusPhotosView *retweetPhotosView = [[BGAStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
}

- (void)setupToolbar {
    BGAStatusToolbar *toolbarView = [BGAStatusToolbar toolbar];
    [self.contentView addSubview:toolbarView];
    self.toolbarView = toolbarView;
}

//- (void)setFrame:(CGRect)frame {
//    frame.origin.y += BGAStatusCellMargin;
//    [super setFrame:frame];
//}

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
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewFrame;
        NSString *vipImageName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipImageName];
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.vipView.hidden = YES;
        
        self.nameLabel.textColor = [UIColor blackColor];
    }
    /** 昵称 */
    self.nameLabel.frame = statusFrame.nameLabelFrame;
    self.nameLabel.text = user.name;
    /** 时间 */
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelFrame.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelFrame) + BGAStatusCellEdge;
    CGSize timeSize = [time sizeWithFont:BGAStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = time;
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + BGAStatusCellEdge;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:BGAStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelFrame;
    self.contentLabel.text = statusFrame.status.text;
    /** 配图 */
    if (status.pic_urls.count) {
        self.photosView.frame = statusFrame.photosViewFrame;
        self.photosView.photos = status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    if (status.retweeted_status) {
        BGAStatus *retweeted_status = status.retweeted_status;
        BGAUser *retweeted_status_user = retweeted_status.user;
        
        self.retweetView.hidden = NO;
        // 转发微博整体
        self.retweetView.frame = statusFrame.retweetViewFrame;
        // 转发微博正文
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelFrame;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        // 被转发微博配图
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewFrame;
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;
        } else {
            self.retweetPhotosView.hidden = YES;
        }
    } else {
        self.retweetView.hidden = YES;
    }
    
    self.toolbarView.status = status;
    
    self.toolbarView.frame = statusFrame.toolbarViewFrame;
}

@end
