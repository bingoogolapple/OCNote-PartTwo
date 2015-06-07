//
//  BGAStatusFrame.m
//  WeiBo
//
//  Created by bingoogol on 15/6/7.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAStatusFrame.h"
#import "BGAStatus.h"

#define BGAStatusCellEdge 10

@implementation BGAStatusFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont*)font {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    return [text sizeWithAttributes:attrs];
}

- (void)setStatus:(BGAStatus *)status {
    _status = status;
    BGAUser *user = status.user;
    
    /** 头像 */
    CGFloat iconWH = 50;
    CGFloat iconX = BGAStatusCellEdge;
    CGFloat iconY = BGAStatusCellEdge;
    self.iconViewFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewFrame) + BGAStatusCellEdge;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:BGAStatusCellNameFont];
    self.nameLabelFrame = (CGRect){{nameX, nameY}, nameSize};
    
    /** 会员图标 */
    if (self.status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelFrame) + BGAStatusCellEdge;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelFrame) + BGAStatusCellEdge;
    CGSize timeSize = [self sizeWithText:status.created_at font:BGAStatusCellTimeFont];
    self.timeLabelFrame = (CGRect){{timeX, timeY}, timeSize};
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.nameLabelFrame) + BGAStatusCellEdge;;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:BGAStatusCellSourceFont];
    self.sourceLabelFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    /** 配图 */
    
    /** 正文 */
    
    /** 原创微博整体 */
    
    
    self.cellHeight = 70;
}

@end