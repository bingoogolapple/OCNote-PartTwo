//
//  BGAProduct.m
//  Lottery
//
//  Created by bingoogol on 15/4/28.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAProduct.h"

@implementation BGAProduct

+ (instancetype)productWithDict:(NSDictionary *)dict {
    BGAProduct *product = [[BGAProduct alloc] init];
    
    product.title = dict[@"title"];
    product.icon = dict[@"icon"];
    product.url = dict[@"url"];
    product.customUrl = dict[@"customUrl"];
    product.ID = dict[@"id"];
    
    return product;
}

//- (void)setIcon:(NSString *)icon {
//    _icon = [icon stringByReplacingOccurrencesOfString:@"@2x.png" withString:@""];
//}

@end
