//
//  BGAStatusPhotoView.m
//  WeiBo
//
//  Created by bingoogol on 15/6/29.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAStatusPhotoView.h"
#import "BGAPhoto.h"
#import "UIImageView+WebCache.h"

@interface BGAStatusPhotoView ()

@property (nonatomic, weak) UIImageView *gifIv;

@end

@implementation BGAStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        /*
         UIViewContentModeScaleToFill,
         UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
         UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
         UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
         UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
         UIViewContentModeTop,
         UIViewContentModeBottom,
         UIViewContentModeLeft,
         UIViewContentModeRight,
         UIViewContentModeTopLeft,
         UIViewContentModeTopRight,
         UIViewContentModeBottomLeft,
         UIViewContentModeBottomRight,
         
         1.凡是带有Scale的都会拉伸
         2.凡是带有Aspect的都会保存原来的宽高比，不会变形
         
         */
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出的部分裁剪掉
        self.clipsToBounds = YES;
    }
    return self;
}

- (UIImageView *)gifIv {
    if (!_gifIv) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifIv = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifIv];
        _gifIv = gifIv;
    }
    return _gifIv;
}

- (void)setPhoto:(BGAPhoto *)photo {
    _photo = photo;
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if ([photo.thumbnail_pic.lowercaseString hasSuffix:@".gif"]) {
        self.gifIv.hidden = NO;
    } else if(_gifIv) {
        _gifIv.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_gifIv && !_gifIv.hidden) {
        _gifIv.x = self.width - _gifIv.width;
        _gifIv.y = self.height - _gifIv.height;
    }
}

@end
