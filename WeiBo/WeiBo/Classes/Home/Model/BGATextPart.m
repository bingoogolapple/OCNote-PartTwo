//
//  BGATextPart.m
//  WeiBo
//
//  Created by bingoogol on 15/7/19.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGATextPart.h"

@implementation BGATextPart
- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
