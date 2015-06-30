//
//  BGAUser.h
//  WeiBo
//
//  Created by bingoogol on 15/5/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    BGAUserVerifiedTypeNone = -1, // 没有任何认证
    
    BGAUserVerifiedPersonal = 0,  // 个人认证
    
    BGAUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    BGAUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    BGAUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    BGAUserVerifiedDaren = 220 // 微博达人
} BGAUserVerifiedType;

@interface BGAUser : NSObject

/**	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;

/**	string	用户头像地址，50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;

/**	值 > 2表示是会员*/
@property (nonatomic, assign) int mbtype;

/**	会员等级*/
@property (nonatomic, assign) int mbrank;
/** 是否是vip */
@property (nonatomic, assign, getter = isVip) BOOL vip;

@property (nonatomic, assign) BGAUserVerifiedType verified_type;

@end