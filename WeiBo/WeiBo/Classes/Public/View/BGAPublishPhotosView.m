//
//  BGAPublishPhotosView.m
//  WeiBo
//
//  Created by bingoogol on 15/7/15.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAPublishPhotosView.h"

@implementation BGAPublishPhotosView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}

- (void)addPhoto:(UIImage *)photo {
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = photo;
    [self addSubview:photoView];
    
    [self.photos addObject:photo];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    
    for (int i = 0; i<count; i++) {
        UIImageView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (imageWH + imageMargin);
        
        int row = i / maxCol;
        photoView.y = row * (imageWH + imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;
    }
}

@end