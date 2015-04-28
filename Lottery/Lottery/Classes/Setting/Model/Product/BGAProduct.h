//
//  BGAProduct.h
//  Lottery
//
//  Created by bingoogol on 15/4/28.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGAProduct : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *customUrl;

+ (instancetype)productWithDict:(NSDictionary *)dict;

@end
