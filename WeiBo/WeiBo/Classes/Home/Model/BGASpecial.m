//
//  BGASpecial.m
//  WeiBo
//
//  Created by bingoogol on 15/7/20.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGASpecial.h"

@implementation BGASpecial
- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
