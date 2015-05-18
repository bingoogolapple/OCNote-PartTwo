//
//  BGAUser.h
//  WeiBo
//
//  Created by bingoogol on 15/5/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGAUser : NSObject

/**	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;

/**	string	用户头像地址，50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;

+ (instancetype)userWithDict:(NSDictionary *)dict;

@end