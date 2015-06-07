//
//  BGAStatusFrame.h
//  WeiBo
//
//  Created by bingoogol on 15/6/7.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//
//  一个BGAStatusFrame模型里面包含的信息
//  1.存放着一个cell内部所有子控件的frame的数据
//  2.存放着一个cell的高度
//  3.存放这一个数据模型BGAStatus

#import <Foundation/Foundation.h>
@class BGAStatus;

@interface BGAStatusFrame : NSObject

@property (nonatomic, strong) BGAStatus *status;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewFrame;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewFrame;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewFrame;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewFrame;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelFrame;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelFrame;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelFrame;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelFrame;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end