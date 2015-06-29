//
//  BGAStatusPhotosView.m
//  WeiBo
//
//  Created by bingoogol on 15/6/28.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAStatusPhotosView.h"
#import "BGAPhoto.h"
#import "BGAStatusPhotoView.h"

#define BGAStatusPhotoWH 70
#define BGAStatusPhotoMargin 5
#define BGAStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation BGAStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos {
    _photos = photos;
    int photosCount = photos.count;
    
    // self.subviews.count不能单独抽出来
    while (self.subviews.count < photosCount) {
        BGAStatusPhotoView *photoView = [[BGAStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    for (int i = 0; i < self.subviews.count; i++) {
        BGAStatusPhotoView *photoView = self.subviews[i];
        if (i < photosCount) {
            photoView.hidden = NO;
            photoView.photo = photos[i];
        } else {
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    int photoCount = self.photos.count;
    int maxCol = BGAStatusPhotoMaxCol(photoCount);
    for (int i = 0; i < photoCount; i++) {
        BGAStatusPhotoView *photoView = self.subviews[i];
        int col = i % maxCol;
        int row = i / maxCol;
        photoView.x = col * (BGAStatusPhotoWH + BGAStatusPhotoMargin);
        photoView.y = row * (BGAStatusPhotoWH + BGAStatusPhotoMargin);
        photoView.width = BGAStatusPhotoWH;
        photoView.height = BGAStatusPhotoWH;
    }
}

+ (CGSize)sizeWithCount:(int)count {
    int maxCol = BGAStatusPhotoMaxCol(count);
    int cols = count > maxCol ? maxCol : count;
    int rows = (count - 1) / maxCol + 1;
    
    CGFloat photosW = cols * BGAStatusPhotoWH + (cols - 1) * BGAStatusPhotoMargin;
    CGFloat photosH = rows * BGAStatusPhotoWH + (rows - 1) * BGAStatusPhotoMargin;
    return CGSizeMake(photosW, photosH);
}

@end