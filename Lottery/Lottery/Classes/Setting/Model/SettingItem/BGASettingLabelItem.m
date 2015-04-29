//
//  BGASettingLabelItem.m
//  Lottery
//
//  Created by bingoogol on 15/4/29.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGASettingLabelItem.h"
#import "BGASaveTool.h"

@implementation BGASettingLabelItem

- (void)setText:(NSString *)text {
    _text = text;
    [BGASaveTool setObject:text forKey:self.title];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    _text = [BGASaveTool objectForKey:title];
}

@end
