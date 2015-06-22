//
//  NSString+Extension.h
//  WeiBo
//
//  Created by bingoogol on 15/6/22.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont*)font;

- (CGSize)sizeWithFont:(UIFont*)font maxWidth:(CGFloat)maxWidth;
@end