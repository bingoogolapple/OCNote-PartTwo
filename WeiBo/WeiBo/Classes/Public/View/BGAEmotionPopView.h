//
//  BGAEmotionPopView.h
//  WeiBo
//
//  Created by bingoogol on 15/7/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BGAEmotion;

@interface BGAEmotionPopView : UIView

+ (instancetype)popView;

@property (nonatomic, strong) BGAEmotion *emotion;

@end
