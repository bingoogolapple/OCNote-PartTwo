//
//  BGAEmotionTextView.h
//  WeiBo
//
//  Created by bingoogol on 15/7/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGATextView.h"

@class BGAEmotion;

@interface BGAEmotionTextView : BGATextView
- (void)insertEmotion:(BGAEmotion *)emotion;

- (NSString *)fullText;
@end
