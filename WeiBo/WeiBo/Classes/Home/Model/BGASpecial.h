//
//  BGASpecial.h
//  WeiBo
//
//  Created by bingoogol on 15/7/20.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGASpecial : NSObject
/** 这段特殊文字的内容 */
@property (nonatomic, copy) NSString *text;
/** 这段特殊文字的范围 */
@property (nonatomic, assign) NSRange range;
/** 这段特殊文字的矩形框（要求数组里面存放CGRect） */
@property (nonatomic, strong) NSArray *rects;
@end
