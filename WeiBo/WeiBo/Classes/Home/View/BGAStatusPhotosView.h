//
//  BGAStatusPhotosView.h
//  WeiBo
//
//  Created by bingoogol on 15/6/28.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGAStatusPhotosView : UIView
@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片个数计算相册尺寸
 *
 *  @param count 图片个数
 *
 *  @return 相册尺寸
 */
+ (CGSize)sizeWithCount:(int)count;
@end