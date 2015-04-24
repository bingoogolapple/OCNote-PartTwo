//
//  BGALoginViewController.m
//  Lottery
//
//  Created by bingoogol on 15/4/24.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGALoginViewController.h"
#import "UIImage+Tool.h"

@interface BGALoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

/*
 Storyboard中UIImageView拉伸Stretching
 x = 0.5 y = 0.5 表示左边和上边一半不拉伸
 width = 0 height = 0 表示拉伸一个像素点，或者都设置成很小的值0.000000000001
 Storyboard中不能通过上面的方式拉伸UIButton
 */
@implementation BGALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginBtn setBackgroundColor:[UIColor clearColor]];
    // 设置登陆按钮的拉伸好的图片，Type选择Custom，否则设置高亮状态无效
    [self.loginBtn setBackgroundImage:[UIImage imageWithResizableImageName:@"RedButton"] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageWithResizableImageName:@"RedButtonPressed"] forState:UIControlStateHighlighted];
}





@end
