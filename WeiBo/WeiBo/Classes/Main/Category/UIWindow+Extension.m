//
//  UIWindow+Extension.m
//  WeiBo
//
//  Created by bingoogol on 15/5/13.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "BGANewFeatureViewController.h"
#import "BGATabBarViewController.h"

#define VersionKey @"CFBundleVersion"

@implementation UIWindow (Extension)
- (void)switchRootViewController {
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:VersionKey];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[VersionKey];
    Logger(@"%@", currentVersion);
    
    if ([currentVersion isEqualToString:lastVersion]) {
        self.rootViewController = [[BGATabBarViewController alloc] init];
    } else {
        self.rootViewController = [[BGANewFeatureViewController alloc] init];
        
        // 将当前版本号存入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:VersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end