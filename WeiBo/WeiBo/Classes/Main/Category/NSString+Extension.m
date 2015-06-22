//
//  NSString+Extension.m
//  WeiBo
//
//  Created by bingoogol on 15/6/22.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

//- (CGSize)sizeWithFont:(UIFont*)font {
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = font;
//    return [self sizeWithAttributes:attrs];
//}

- (CGSize)sizeWithFont:(UIFont*)font {
    return [self sizeWithFont:font maxWidth:MAXFLOAT];
}

- (CGSize)sizeWithFont:(UIFont*)font maxWidth:(CGFloat)maxWidth {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end