//
//  UIImage+Tool.m
//  Lottery
//
//  Created by bingoogol on 15/4/24.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)

+ (instancetype)imageWithResizableImageName:(NSString *)imgName {
    UIImage *image = [UIImage imageNamed:imgName];
    // right cap is calculated as width - leftCapWidth - 1
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

- (UIImage *)stretchImg2:(UIImage *)image {
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height - top - 1;
    CGFloat right = image.size.width - left - 1;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)];
}

@end
