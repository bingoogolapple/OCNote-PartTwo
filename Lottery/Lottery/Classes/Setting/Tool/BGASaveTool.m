//
//  BGASaveTool.m
//  Lottery
//
//  Created by bingoogol on 15/4/29.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGASaveTool.h"

@implementation BGASaveTool

+ (void)setObject:(id)value forKey:(NSString *)defaultName {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)objectForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] stringForKey:defaultName];
}

@end