//
//  BGALoadMoreFooter.m
//  WeiBo
//
//  Created by bingoogol on 15/5/19.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGALoadMoreFooter.h"

@implementation BGALoadMoreFooter

+ (instancetype)footer {
    return [[[NSBundle mainBundle] loadNibNamed:@"BGALoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
