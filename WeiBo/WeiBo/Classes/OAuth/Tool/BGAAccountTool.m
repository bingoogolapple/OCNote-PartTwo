//
//  BGAAccountTool.m
//  WeiBo
//
//  Created by bingoogol on 15/5/13.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAAccountTool.h"
#import "BGAAccount.h"

#define BGAAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archiver"]

@implementation BGAAccountTool

+ (void)saveAccount:(BGAAccount *)account {
    // 获得账号对象存储的时间
    account.created_time = [NSDate date];
    
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:BGAAccountPath];
}

+ (BGAAccount *)account {
    BGAAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:BGAAccountPath];
    // 过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    
    NSDate *now = [NSDate date];
    
    Logger(@"%@ -- %@", expiresTime, now);
    
    // 如果expiresTime <= now，过期
    /**
     *  NSComparisonResult
     *  NSOrderedAscending = -1L  升序，右边 > 左边
     *  NSOrderedSame 一样
     *  NSOrderedDescending 降序，右边 < 左边
     */
    if([expiresTime compare:now] == NSOrderedAscending) {
        return nil;
    }
    
    return account;
}

@end