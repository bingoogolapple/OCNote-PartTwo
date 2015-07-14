//
//  BGAPublishViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/7/9.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAPublishViewController.h"
#import "BGAAccountTool.h"
#import "BGATextView.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "BGAPublishToolbar.h"

@interface BGAPublishViewController()<UITextViewDelegate, BGAPublishToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/** 输入控件 */
@property (nonatomic, weak) BGATextView *textView;
/** 键盘顶部的工具条 */
@property (nonatomic, weak) BGAPublishToolbar *toolbar;

@end


@implementation BGAPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolbar];
}

- (void)setupToolbar {
    BGAPublishToolbar *toolbar = [[BGAPublishToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    
    // 设置显示在键盘顶部的控件
//    self.textView.inputAccessoryView = toolbar;
    
    toolbar.delegate = self;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
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
    // 垂直方向上永远可以拖拽（有弹簧效果）
    textView.alwaysBounceVertical = YES;
    // 不会判断是否被导航栏遮住
    // textView.y = 80;
    // 按住option键，点击属性快速查看文档
    textView.font = [UIFont systemFontOfSize:15];
//    textView.backgroundColor = [UIColor redColor];
//    textView.textColor = [UIColor greenColor];
    textView.placeholder = @"分享新鲜事...";
    textView.placeholderColor = [UIColor grayColor];
    
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 监听文字改变通知
    [BGANotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 键盘通知
    // 键盘的frame发生改变时发出的通知（位置和尺寸）
    //    UIKeyboardWillChangeFrameNotification
    //    UIKeyboardDidChangeFrameNotification
    // 键盘显示时发出的通知
    //    UIKeyboardWillShowNotification
    //    UIKeyboardDidShowNotification
    // 键盘隐藏时发出的通知
    //    UIKeyboardWillHideNotification
    //    UIKeyboardDidHideNotification
    [BGANotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/**
 * 键盘的frame发生改变时调用（显示、隐藏等）
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    /**
     notification.userInfo = @{
     // 键盘弹出\隐藏后的frame
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 352}, {320, 216}},
     // 键盘弹出\隐藏所耗费的时间
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     // 键盘弹出\隐藏动画的执行节奏（先快后慢，匀速）
     UIKeyboardAnimationCurveUserInfoKey = 7
     }
     */
    
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > self.view.height) {
            // 键盘的Y值已经远远超过了控制器view的高度
            self.toolbar.y = self.view.height - self.toolbar.height;
        } else {
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }
        Logger(@"%@", NSStringFromCGRect(self.toolbar.frame));
    }];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    [self sendWithoutImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendWithoutImage {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [BGAAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)publishToolbar:(BGAPublishToolbar *)toolbar didClickButton:(BGAPublishToolbarButtonType)buttonType {
    switch (buttonType) {
        case BGAPublishToolbarButtonTypeCamera:
            Logger(@"拍照");
            break;
        case BGAPublishToolbarButtonTypePicture:
           Logger(@"相册");
            break;
        case BGAPublishToolbarButtonTypeMention:
            Logger(@"@");
            break;
        case BGAPublishToolbarButtonTypeTrend:
            Logger(@"#");
            break;
        case BGAPublishToolbarButtonTypeEmotion:
            Logger(@"表情");
            break;
        default:
            break;
    }
}

@end
