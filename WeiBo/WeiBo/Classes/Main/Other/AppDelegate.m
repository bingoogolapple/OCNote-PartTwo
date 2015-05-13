//
//  AppDelegate.m
//  WeiBo
//
//  Created by bingoogol on 15/5/3.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "AppDelegate.h"
#import "BGATabBarViewController.h"
#import "BGANewFeatureViewController.h"
#import "BGAOAuthViewController.h"
#import "BGAAccount.h"

#define VersionKey @"CFBundleVersion"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"account.archiver"];
    BGAAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (account) {
        // 之前已经登录成功
        [self checkVersion];
    } else {
        self.window.rootViewController = [[BGAOAuthViewController alloc] init];
    }
    
    // 3.显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)checkVersion {
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:VersionKey];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[VersionKey];
    Logger(@"%@", currentVersion);
    if ([currentVersion isEqualToString:lastVersion]) {
        self.window.rootViewController = [[BGATabBarViewController alloc] init];
    } else {
        self.window.rootViewController = [[BGANewFeatureViewController alloc] init];
        
        // 将当前版本号存入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:VersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
