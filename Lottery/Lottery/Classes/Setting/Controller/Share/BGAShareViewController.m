//
//  BGAShareViewController.m
//  Lottery
//
//  Created by bingoogol on 15/4/30.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAShareViewController.h"
#import "BGASettingArrowItem.h"
#import "BGASettingGroup.h"

#import <MessageUI/MessageUI.h>

@interface BGAShareViewController ()<MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>
@property (nonatomic, assign) int age;
@end

@implementation BGAShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup0];
}

- (void)addGroup0 {
    __weak BGAShareViewController *share = self;
    BGASettingArrowItem *mail = [BGASettingArrowItem itemWithIcon:@"MailShare" title:@"邮件分享"];
    mail.option = ^{
        // 用自带的邮件客户端，发完邮件后不会自动回到原应用
//        NSURL *url = [NSURL URLWithString:@"mailto://10010@qq.com"];
//        [[UIApplication sharedApplication] openURL:url];

        // 不能发邮件
        if (![MFMailComposeViewController canSendMail]) {
            Logger(@"不能发送邮件");
            return;
        }
        
        MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
        
        // 设置邮件主题
        [vc setSubject:@"会议"];
        // 设置邮件内容
        [vc setMessageBody:@"今天下午开会吧" isHTML:NO];
        // 设置收件人列表
        [vc setToRecipients:@[@"sdfsdfsdf@qq.com"]];
        // 设置抄送人列表
        [vc setCcRecipients:@[@"sdfsfs@qq.com"]];
        // 设置密送人列表
        [vc setBccRecipients:@[@"5sdfsdf6789@qq.com"]];
        
        
        // 添加附件（一张图片）
        UIImage *image = [UIImage imageNamed:@"aliavator"];
        NSData *data = UIImagePNGRepresentation(image);
        [vc addAttachmentData:data mimeType:@"image/png" fileName:@"aliavator.png"];
        // 设置代理
//        vc.mailComposeDelegate = self;
//        [self presentViewController:vc animated:YES completion:nil];
        vc.mailComposeDelegate = share;
        [share presentViewController:vc animated:YES completion:nil];
    };
    BGASettingArrowItem *sms = [BGASettingArrowItem itemWithIcon:@"SmsShare" title:@"短信分享"];
    sms.option = ^{
        // 直接跳到发短信界面，但是不能指定短信内容，而且不能自动回到原应用
//        NSURL *url = [NSURL URLWithString:@"sms://10010"];
//        [[UIApplication sharedApplication] openURL:url];

        
        MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
        // 设置短信内容
        vc.body = @"吃饭了没？";
        // 设置收件人列表
        vc.recipients = @[@"10010", @"13693437925"];
        // 设置代理
//        vc.messageComposeDelegate = self;
//        [self presentViewController:vc animated:YES completion:nil];
        // _age 的本质是 self->_age;
////        _age;
//        share.age;
        
        // block中不能使用self,和_成员变量，否则会出现循环引用
        
        vc.messageComposeDelegate = share;
        [share presentViewController:vc animated:YES completion:nil];
    };
    BGASettingArrowItem *sina = [BGASettingArrowItem itemWithIcon:@"WeiboSina" title:@"新浪分享"];
    BGASettingGroup *group0 = [[BGASettingGroup alloc] init];
    group0.items = @[sina, sms, mail];
    [self.dataList addObject:group0];
}

// 当你取消发送短信的时候调用
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled) {
        NSLog(@"取消发送");
    } else if (result == MessageComposeResultSent) {
        NSLog(@"已经发出");
    } else {
        NSLog(@"发送失败");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    // 关闭邮件界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MFMailComposeResultCancelled) {
        NSLog(@"取消发送");
    } else if (result == MFMailComposeResultSent) {
        NSLog(@"已经发出");
    } else {
        NSLog(@"发送失败");
    }
}

- (void)dealloc {
    Logger(@"%s", __func__);
}



@end
