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
#import "BGAAccount.h"
#import "MBProgressHUD+MJ.h"
#import "BGAAccountTool.h"
#import "BGAHttpTool.h"

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
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    Logger(@"%s", __func__);
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    Logger(@"%s", __func__);
    [MBProgressHUD hideHUD];
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
    //client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET&grant_type=authorization_code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI&code=CODE
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = self.local.clientId;
    params[@"client_secret"] = self.local.clientSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = self.local.redirectUri;
    params[@"code"] = code;
    
    
    [BGAHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        [MBProgressHUD hideHUD];
        // uid一个用户就一个,access_token一个用户给一个应用授权手会获得对应的一个accessToken
        Logger(@"请求成功 - %@", json);
        
        // 存储账号信息
        BGAAccount *account = [BGAAccount accountWithDict:json];
        [BGAAccountTool saveAccount:account];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
    } failure:^(NSError *error) {
        Logger(@"请求失败 - %@", error);
        [MBProgressHUD hideHUD];
    }];
}

@end