//
//  BGAHtmlViewController.m
//  Lottery
//
//  Created by bingoogol on 15/4/29.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAHtmlViewController.h"
#import "BGAHtml.h"

@interface BGAHtmlViewController ()<UIWebViewDelegate>

@end

@implementation BGAHtmlViewController

- (void)loadView {
    self.view = [[UIWebView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    
    UIWebView *webView = (UIWebView *)self.view;
    webView.delegate = self;
    NSURL *url = [[NSBundle mainBundle] URLForResource:_html.html withExtension:nil];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 一定要在网页加载玩之后执行
    NSString *js = [NSString stringWithFormat:@"window.location.href='#%@'", _html.ID];
    [webView stringByEvaluatingJavaScriptFromString:js];
}


@end
