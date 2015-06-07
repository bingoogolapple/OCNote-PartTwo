//
//  BGAUser.m
//  WeiBo
//
//  Created by bingoogol on 15/5/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAUser.h"

@implementation BGAUser

- (void)setMbtype:(int)mbtype {
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}

// 每调一次就会算一次，这样不好
//- (BOOL)isVip {
//    return self.mbtype > 2;
//}

@end