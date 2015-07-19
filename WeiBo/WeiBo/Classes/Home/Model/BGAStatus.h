//
//  BGAStatus.h
//  WeiBo
//
//  Created by bingoogol on 15/5/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGAUser.h"

@interface BGAStatus : NSObject

/**	string	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	微博信息内容*/
@property (nonatomic, copy) NSString *text;
/**	string	微博信息内容 -- 带有属性的(特殊文字会高亮显示\显示表情)*/
@property (nonatomic, copy) NSAttributedString *attributedText;

/**	object	微博作者的用户信息字段 详细*/
@property (nonatomic, strong) BGAUser *user;

/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;

/** 源微博配图地址 */
@property (nonatomic, strong) NSArray *pic_urls;

/** 被转发的原微博 */
@property (nonatomic, strong) BGAStatus *retweeted_status;
/**	被转发的原微博信息内容 -- 带有属性的(特殊文字会高亮显示\显示表情)*/
@property (nonatomic, copy) NSAttributedString *retweetedAttributedText;

/** 转发数 */
@property (nonatomic, assign) int reposts_count;

/** 评论数 */
@property (nonatomic, assign) int comments_count;

/** 赞数 */
@property (nonatomic, assign) int attitudes_count;

@end