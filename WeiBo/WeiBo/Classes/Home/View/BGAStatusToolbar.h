//
//  BGAStatusToolbar.h
//  WeiBo
//
//  Created by bingoogol on 15/6/17.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BGAStatus;

@interface BGAStatusToolbar : UIView

+ (instancetype)toolbar;

@property (nonatomic, strong) BGAStatus *status;

@end
