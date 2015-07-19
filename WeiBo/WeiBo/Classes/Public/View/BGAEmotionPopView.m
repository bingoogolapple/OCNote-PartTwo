//
//  BGAEmotionPopView.m
//  WeiBo
//
//  Created by bingoogol on 15/7/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAEmotionPopView.h"
#import "BGAEmotion.h"
#import "BGAEmotionButton.h"

@interface BGAEmotionPopView ()

@property (weak, nonatomic) IBOutlet BGAEmotionButton *emotionButton;

@end

@implementation BGAEmotionPopView

+ (instancetype)popView {
    return [[[NSBundle mainBundle] loadNibNamed:@"BGAEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFrom:(BGAEmotionButton *)button {
    if (button == nil) return;
    
    // 给popView传递数据
    self.emotionButton.emotion = button.emotion;
    
    // 取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) - self.height;
    self.centerX = CGRectGetMidX(btnFrame);
}

@end
