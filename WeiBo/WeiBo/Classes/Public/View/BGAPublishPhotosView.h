//
//  BGAPublishPhotosView.h
//  WeiBo
//
//  Created by bingoogol on 15/7/15.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGAPublishPhotosView : UIView

@property (nonatomic, strong, readonly) NSMutableArray *photos;

- (void)addPhoto:(UIImage *)photo;

// 默认会自动生成setter和getter的声明和实现、_开头的成员变量
// 如果手动实现了setter和getter，那么就不会再生成settter、getter的实现、_开头的成员变量

//@property (nonatomic, strong, readonly) NSMutableArray *addedPhotos;
// 默认会自动生成getter的声明和实现、_开头的成员变量
// 如果手动实现了getter，那么就不会再生成getter的实现、_开头的成员变量

@end
