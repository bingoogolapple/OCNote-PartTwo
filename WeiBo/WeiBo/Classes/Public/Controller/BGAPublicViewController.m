//
//  BGAPublicViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/7/9.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAPublicViewController.h"
#import "BGAAccountTool.h"
#import "BGATextView.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"

@interface BGAPublicViewController()

/** 输入控件 */
@property (nonatomic, weak) BGATextView *textView;

@end


@implementation BGAPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
}

- (void)setupTextView {
    
    // UITextField只有一行，当有导航栏时内容会被导航栏遮住
    // UITextView可以有多行，继承自ScrollView，会自定判断是否有导航栏来设置contentInset使内容不被导航来遮住
    // 默认是YES:当scrollView遇到UINavigationBar、UITabBar等控件时，默认会设置ScrollView的contentInset
    // UIViewController.automaticallyAdjustsScrollViewInsets = NO;
    
    /**
     UITextField:
     1.文字永远是一行，不能显示多行文字
     2.有placehoder属性设置占位文字
     3.继承自UIControl
     4.监听行为
     1> 设置代理
     2> addTarget:action:forControlEvents:
     3> 通知:UITextFieldTextDidChangeNotification
     
     UITextView:
     1.能显示任意行文字
     2.不能设置占位文字
     3.继承自UIScollView
     4.监听行为
     1> 设置代理
     2> 通知:UITextViewTextDidChangeNotification
     */
    
    BGATextView *textView = [[BGATextView alloc] init];
    textView.frame = self.view.bounds;
    // 不会判断是否被导航栏遮住
    // textView.y = 80;
    // 按住option键，点击属性快速查看文档
    textView.font = [UIFont systemFontOfSize:15];
//    textView.backgroundColor = [UIColor redColor];
//    textView.textColor = [UIColor greenColor];
    textView.placeholder = @"分享新鲜事...";
    textView.placeholderColor = [UIColor grayColor];
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 监听文字改变通知
    [BGANotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
}

/**
 * 监听文字改变
 */
- (void)textDidChange {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void)dealloc {
    [BGANotificationCenter removeObserver:self];
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    UILabel *titleView = [[UILabel alloc] init];
    // A value of 0 means no limit   这个一定要设置，否则不能换行
    titleView.numberOfLines = 0;
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.width = 200;
    titleView.height = 44;
    
    NSString *username = [BGAAccountTool account].name;
    NSString *prefix = @"发微博";
    // 网速慢时，用户名可能为空
    if (username) {
        NSString *title = [NSString stringWithFormat:@"%@\n%@", prefix, username];
        NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:title];
        [attrTitle addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[title rangeOfString:prefix]];
        [attrTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[title rangeOfString:username]];
        [attrTitle addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[title rangeOfString:username]];
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor redColor];
        shadow.shadowOffset = CGSizeMake(2, 2);
        [attrTitle addAttribute:NSShadowAttributeName value:shadow range:[title rangeOfString:prefix]];
        
        titleView.attributedText = attrTitle;
        self.navigationItem.titleView = titleView;
    } else {
        self.title = prefix;
    }
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [BGAAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
