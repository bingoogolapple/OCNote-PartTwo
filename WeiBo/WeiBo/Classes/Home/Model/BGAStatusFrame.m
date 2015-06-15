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

//- (CGSize)sizeWithText:(NSString *)text font:(UIFont*)font {
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = font;
//    return [text sizeWithAttributes:attrs];
//}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont*)font {
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont*)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (void)setStatus:(BGAStatus *)status {
    _status = status;
    BGAUser *user = status.user;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
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
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewFrame), CGRectGetMaxY(self.timeLabelFrame)) + BGAStatusCellEdge;
    CGFloat maxW = cellW - 2 * BGAStatusCellEdge;
    CGSize contentSize = [self sizeWithText:status.text font:BGAStatusCellContentFont maxW:maxW];
    self.contentLabelFrame = (CGRect){{contentX, contentY}, contentSize};
    /** 配图 */
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelFrame) + BGAStatusCellEdge;
        self.photoViewFrame = CGRectMake(photoX, photoY, photoWH, photoWH);
        
        originalH = CGRectGetMaxY(self.photoViewFrame) + BGAStatusCellEdge;
    } else {
        originalH = CGRectGetMaxY(self.contentLabelFrame) + BGAStatusCellEdge;
    }
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    self.originalViewFrame = CGRectMake(originalX, originalY, originalW, originalH);
    
    if (status.retweeted_status) {
        // 被转发微博
        
        BGAStatus *retweeted_status = status.retweeted_status;
        BGAUser *retweeted_status_user = retweeted_status.user;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        
        CGFloat retweetContentX = BGAStatusCellEdge;
        CGFloat retweetContentY = BGAStatusCellEdge;
        
        CGFloat retweetContentMaxW = cellW - 2 * BGAStatusCellEdge;
        CGSize retweetContentSize = [self sizeWithText:retweetContent font:BGARetweetStatusCellContentFont maxW:retweetContentMaxW];
        self.retweetContentLabelFrame = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        
        
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) {
            CGFloat retweetPhotoWH = 100;
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelFrame) + BGAStatusCellEdge;
            self.retweetPhotoViewFrame = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
            
            retweetH = CGRectGetMaxY(self.retweetPhotoViewFrame) + BGAStatusCellEdge;
        } else {
            retweetH = CGRectGetMaxY(self.retweetContentLabelFrame) + BGAStatusCellEdge;
        }
        
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewFrame);
        CGFloat retweetW = cellW;
        self.retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        self.cellHeight = CGRectGetMaxY(self.retweetViewFrame);
    } else {
        self.cellHeight = CGRectGetMaxY(self.originalViewFrame);
    }
}

@end