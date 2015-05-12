//
//  BGALocal.h
//  WeiBo
//
//  Created by bingoogol on 15/5/12.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGALocal : NSObject

@property (nonatomic, copy) NSString *clientId;
@property (nonatomic, copy) NSString *clientSecret;
@property (nonatomic, copy) NSString *redirectUri;

+ (instancetype)localWithDict:(NSDictionary *)dict;

@end