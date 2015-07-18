//
//  BGAEmotionPageView.h
//  WeiBo
//
//  Created by bingoogol on 15/7/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>

// 一页中最多3行
#define BGAEmotionMaxRows 3
// 一行中最多7列
#define BGAEmotionMaxCols 7
// 每一页的表情个数
#define BGAEmotionPageSize ((BGAEmotionMaxRows * BGAEmotionMaxCols) - 1)

@interface BGAEmotionPageView : UIView
/** 这一页显示的表情（里面都是BGAEmotion模型） */
@property (nonatomic, strong) NSArray *emotions;

@end