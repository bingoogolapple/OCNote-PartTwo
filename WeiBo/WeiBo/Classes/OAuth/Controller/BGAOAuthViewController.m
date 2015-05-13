//
//  BGAOAuthViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/5/11.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAOAuthViewController.h"
#import "AFNetworking.h"
#import "BGALocal.h"
#import "BGATabBarViewController.h"
#import "BGANewFeatureViewController.h"
#import "BGAAccount.h"

#define VersionKey @"CFBundleVersion"

@interface BGAOAuthViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) BGALocal *local;
@end

@implementation BGAOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 回调地址默认是http://
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", self.local.clientId, self.local.redirectUri];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (BGALocal *)local {
    if (_local == nil) {
        NSString *fileName = [[NSBundle mainBundle] pathForResource:@"local.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:fileName];
        NSDictionary *localDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _local = [BGALocal localWithDict:localDict];
        Logger(@"%@", _local);
    }
    return _local;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    Logger(@"%s", __func__);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    Logger(@"%s", __func__);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    Logger(@"%s", __func__);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    Logger(@"%s -- %@", __func__, request.URL.absoluteString);
    
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        int fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        Logger(@"code = %@", code);
        
        [self accessTokenWithCode:code];
        
        // 禁止加载回调地址
        return NO;
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 默认的序列化器就是json
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // Request failed: unacceptable content-type: text/plain   新浪返回的头不是json，但是又是json格式的字符串，修改AFJSONResponseSerializer源码，设置可接收的格式
    
    //client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET&grant_type=authorization_code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI&code=CODE
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = self.local.clientId;
    params[@"client_secret"] = self.local.clientSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = self.local.redirectUri;
    params[@"code"] = code;
    
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // uid一个用户就一个,access_token一个用户给一个应用授权手会获得对应的一个accessToken
        Logger(@"请求成功 - %@", responseObject);
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [doc stringByAppendingPathComponent:@"account.archiver"];
        
        BGAAccount *account = [BGAAccount accountWithDict:responseObject];
        // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
        [NSKeyedArchiver archiveRootObject:account toFile:path];
        
        [self checkVersion];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        Logger(@"请求失败 - %@", error);
    }];
}

- (void)checkVersion {
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:VersionKey];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[VersionKey];
    Logger(@"%@", currentVersion);
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {
        window.rootViewController = [[BGATabBarViewController alloc] init];
    } else {
        window.rootViewController = [[BGANewFeatureViewController alloc] init];
        
        // 将当前版本号存入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:VersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end