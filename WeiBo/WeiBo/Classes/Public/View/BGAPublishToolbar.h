//
//  BGAPublishToolbar.h
//  WeiBo
//
//  Created by bingoogol on 15/7/15.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BGAPublishToolbarButtonTypeCamera, // 拍照
    BGAPublishToolbarButtonTypePicture, // 相册
    BGAPublishToolbarButtonTypeMention, // @
    BGAPublishToolbarButtonTypeTrend, // #
    BGAPublishToolbarButtonTypeEmotion // 表情
} BGAPublishToolbarButtonType;


@class BGAPublishToolbar;

@protocol BGAPublishToolbarDelegate <NSObject>
@optional
- (void)publishToolbar:(BGAPublishToolbar *)toolbar didClickButton:(BGAPublishToolbarButtonType)buttonType;
@end

@interface BGAPublishToolbar : UIView
@property (nonatomic, weak) id<BGAPublishToolbarDelegate> delegate;
@end
