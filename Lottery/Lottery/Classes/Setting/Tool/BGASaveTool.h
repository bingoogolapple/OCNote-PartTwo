//
//  BGASaveTool.h
//  Lottery
//
//  Created by bingoogol on 15/4/29.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGASaveTool : NSObject

+ (void)setObject:(id)value forKey:(NSString *)defaultName;

+ (id)objectForKey:(NSString *)defaultName;

@end
