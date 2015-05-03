//
//  AppDelegate.m
//  Lottery
//
//  Created by bingoogol on 15/4/6.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAAppDelegate.h"
#import "UMSocial.h"

@interface BGAAppDelegate ()

@end

@implementation BGAAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // ios6显示状态栏
    application.statusBarHidden = NO;
    // ios6中记得在AppIcon的属性中勾选iOS icon is pre-rendered否则会有毛玻璃效果
    
    // info中配置View controller-based status bar appearance为NO，使控制器不能设置状态栏样式
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    [UMSocialData setAppKey:@"55458cd167e58ef2f8000827"];
    
    return YES;
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
