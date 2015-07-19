//
//  BGAStatusFrame.m
//  WeiBo
//
//  Created by bingoogol on 15/6/7.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAStatusFrame.h"
#import "BGAStatus.h"
#import "BGAStatusPhotosView.h"

@implementation BGAStatusFrame

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
    CGSize nameSize = [user.name sizeWithFont:BGAStatusCellNameFont];
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
    CGSize timeSize = [status.created_at sizeWithFont:BGAStatusCellTimeFont];
    self.timeLabelFrame = (CGRect){{timeX, timeY}, timeSize};
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelFrame) + BGAStatusCellEdge;;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:BGAStatusCellSourceFont];
    self.sourceLabelFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewFrame), CGRectGetMaxY(self.timeLabelFrame)) + BGAStatusCellEdge;
    CGFloat maxW = cellW - 2 * BGAStatusCellEdge;
//    CGSize contentSize = [status.text sizeWithFont:BGAStatusCellContentFont maxWidth:maxW];
    CGSize contentSize = [status.attributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.contentLabelFrame = (CGRect){{contentX, contentY}, contentSize};
    /** 配图 */
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentLabelFrame) + BGAStatusCellEdge;
        CGSize photosSize = [BGAStatusPhotosView sizeWithCount:status.pic_urls.count];
        self.photosViewFrame = (CGRect){{photosX, photosY}, photosSize};
        
        originalH = CGRectGetMaxY(self.photosViewFrame) + BGAStatusCellEdge;
    } else {
        originalH = CGRectGetMaxY(self.contentLabelFrame) + BGAStatusCellEdge;
    }
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = BGAStatusCellMargin;
    CGFloat originalW = cellW;
    self.originalViewFrame = CGRectMake(originalX, originalY, originalW, originalH);
    
    CGFloat toolbarY = 0;
    if (status.retweeted_status) {
        // 被转发微博
        BGAStatus *retweeted_status = status.retweeted_status;
        
        CGFloat retweetContentX = BGAStatusCellEdge;
        CGFloat retweetContentY = BGAStatusCellEdge;
        
//        CGSize retweetContentSize = [retweetContent sizeWithFont:BGARetweetStatusCellContentFont maxWidth:maxW];
        CGSize retweetContentSize = [status.retweetedAttributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        self.retweetContentLabelFrame = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) {
            CGFloat retweetPhotosX = retweetContentX;
            CGFloat retweetPhotosY = CGRectGetMaxY(self.retweetContentLabelFrame) + BGAStatusCellEdge;
            CGSize retweetPhotosSize = [BGAStatusPhotosView sizeWithCount:retweeted_status.pic_urls.count];
            self.retweetPhotosViewFrame = (CGRect){{retweetPhotosX, retweetPhotosY}, retweetPhotosSize};
            
            retweetH = CGRectGetMaxY(self.retweetPhotosViewFrame) + BGAStatusCellEdge;
        } else {
            retweetH = CGRectGetMaxY(self.retweetContentLabelFrame) + BGAStatusCellEdge;
        }
        
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewFrame);
        CGFloat retweetW = cellW;
        self.retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        toolbarY = CGRectGetMaxY(self.retweetViewFrame);
    } else {
        toolbarY = CGRectGetMaxY(self.originalViewFrame);
    }
    
    // 工具条
    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    self.toolbarViewFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    self.cellHeight = CGRectGetMaxY(self.toolbarViewFrame);
}

@end