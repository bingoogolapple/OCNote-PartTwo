//
//  BGAPublishViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/7/9.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAPublishViewController.h"
#import "BGAAccountTool.h"
#import "BGAEmotionTextView.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "BGAPublishToolbar.h"
#import "BGAPublishPhotosView.h"
#import "BGAEmotionKeyboard.h"
#import "BGAEmotion.h"
#import "BGAHttpTool.h"

@interface BGAPublishViewController()<UITextViewDelegate, BGAPublishToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/** 输入控件 */
@property (nonatomic, weak) BGAEmotionTextView *textView;
/** 键盘顶部的工具条 */
@property (nonatomic, weak) BGAPublishToolbar *toolbar;
/** 相册（存放拍照或者相册中选择的图片） */
@property (nonatomic, weak) BGAPublishPhotosView *photosView;

//@property (nonatomic, assign) BOOL  picking;

/** 表情键盘 */
@property (nonatomic, strong) BGAEmotionKeyboard *emotionKeyboard;
/** 是否正在切换键盘 */
@property (nonatomic, assign) BOOL switchingKeybaord;

@end


@implementation BGAPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolbar];
    
    // 添加相册
    [self setupPhotosView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 不要放在viewWillAppear里，键盘会受modal影响
    // 能输入文本的控件一旦成为第一响应者，就会叫出【相应】的键盘
    [self.textView becomeFirstResponder];
}

- (void)setupPhotosView {
    BGAPublishPhotosView *photosView = [[BGAPublishPhotosView alloc] init];
    photosView.y = 100;
    photosView.width = self.view.width;
    // 随便写的
    photosView.height = self.view.height;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
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
    
    BGAEmotionTextView *textView = [[BGAEmotionTextView alloc] init];
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
    
    // 表情选中的通知
    [BGANotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:BGAEmotionDidSelectNotification object:nil];
    
    // 删除文字的通知
    [BGANotificationCenter addObserver:self selector:@selector(emotionDidDelete) name:BGAEmotionDidDeleteNotification object:nil];
}

- (void)emotionDidDelete {
    [self.textView deleteBackward];
}

- (void)emotionDidSelect:(NSNotification *)notification {
    BGAEmotion *emotion = notification.userInfo[BGASelectEmotionKey];
    [self.textView insertEmotion:emotion];
}

/**
 * 键盘的frame发生改变时调用（显示、隐藏等）
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    //    if (self.picking) return;
    
    // 如果正在切换键盘，就不要执行后面的代码【只拦截旧键盘的收缩】
    if (self.switchingKeybaord) return;
    
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
    Logger(@"textDidChange");
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
    if (self.photosView.photos.count) {
        [self sendWithImage];
    } else {
        [self sendWithoutImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendWithImage {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [BGAAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)sendWithoutImage {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [BGAAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    
    [BGAHttpTool post:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id json) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)publishToolbar:(BGAPublishToolbar *)toolbar didClickButton:(BGAPublishToolbarButtonType)buttonType {
    switch (buttonType) {
        case BGAPublishToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case BGAPublishToolbarButtonTypePicture:
            [self openAlbum];
            break;
        case BGAPublishToolbarButtonTypeMention:
            Logger(@"@");
            break;
        case BGAPublishToolbarButtonTypeTrend:
            Logger(@"#");
            break;
        case BGAPublishToolbarButtonTypeEmotion:
            [self switchKeyboard];
            break;
        default:
            break;
    }
}

- (BGAEmotionKeyboard *)emotionKeyboard {
    if (!_emotionKeyboard) {
        _emotionKeyboard = [[BGAEmotionKeyboard alloc] init];
        _emotionKeyboard.width = self.view.width;
        _emotionKeyboard.height = 216;
    }
    return _emotionKeyboard;
}

- (void)switchKeyboard {
    if (self.textView.inputView == nil) {
        // 切换为自定义的表情键盘
        self.textView.inputView = self.emotionKeyboard;
        // 显示键盘按钮
        self.toolbar.showKeyboardButton = YES;
    } else {
        // 切换为系统自带的键盘
        self.textView.inputView = nil;
        // 显示表情按钮
        self.toolbar.showKeyboardButton = NO;
    }
    // 开始切换键盘
    self.switchingKeybaord = YES;
    
    // 退出键盘
    [self.textView endEditing:YES];
    //    [self.view endEditing:YES];
    //    [self.view.window endEditing:YES];
    //    [self.textView resignFirstResponder];
    
    // 结束切换键盘
    self.switchingKeybaord = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.textView becomeFirstResponder];
    });
}

- (void)openCamera {
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openAlbum {
    // 如果想自己写一个图片选择控制器，得利用AssetsLibrary.framework，利用这个框架可以获得手机上的所有相册图片
    // UIImagePickerControllerSourceTypePhotoLibrary 里的图片多余 UIImagePickerControllerSourceTypeSavedPhotosAlbum
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type {
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    //    self.picking = YES;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 * 从UIImagePickerController选择完图片后就调用（拍照完毕或者选择相册图片完毕）
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // info中就包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 添加图片到photosView中
    [self.photosView addPhoto:image];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        self.picking = NO;
    //    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        self.picking = NO;
    //    });
}

// 存储图片到相册
// UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@""]];
// UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);



@end
