//
//  BGAOAuthViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/5/11.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAOAuthViewController.h"

@interface BGAOAuthViewController ()<UIWebViewDelegate>

@end

@implementation BGAOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 回调地址默认是http://
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3748232885&redirect_uri=http://www.bingoogolapple.cn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
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
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code {
    
}

@end