//
//  BGADropdownMenu.m
//  WeiBo
//
//  Created by bingoogol on 15/5/5.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGADropdownMenu.h"

@interface BGADropdownMenu()

@property (nonatomic, strong) UIImageView *containerView;

@end

@implementation BGADropdownMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)menu {
    return [[self alloc] init];
}

- (UIImageView *)containerView {
    if (!_containerView) {
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.userInteractionEnabled = YES;
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.width = 217;
        containerView.height = 217;
        [self addSubview:containerView];
        _containerView = containerView;
    }
    return _containerView;
}

- (void)setContent:(UIView *)content {
    _content = content;
    content.x = 10;
    content.y = 15;
//    content.width = self.containerView.width - 2 * content.x;
    
    // 图片设置为拉伸stretches，而不是平铺tiles
    // 这样做的话顶部的箭头在水平方向上会有拉伸
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    // CGRectGetMaxY(content.frame) 等于 content.y + content.height
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    
    [self.containerView addSubview:content];
}

- (void)setContentController:(UIViewController *)contentController {
    _contentController = contentController;
    self.content = contentController.view;
}

- (void)showFrom:(UIView *)from {
    // 1.获得最上面的窗口
    // 如果在controller中，self.view.window不可靠，某些情况下为nil
    // [UIApplication sharedApplication].keyWindow获取window时，如果已经弹出了键盘，还是会被键盘遮住
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 2.添加自己到窗口上
    [window addSubview:self];
    
    // 3.设置尺寸
    self.frame = window.bounds;
    
    // 4.调整灰色图片的位置
    // 默认情况下，frame是以父控件左上角为坐标原点
    // 转换坐标系
//    CGRect newFrame = [from convertRect:from.bounds toView:window];
    // 和上面那句是等效的，如果toView为nil则是计算在主窗口中的位置
    CGRect newFrame = [from.superview convertRect:from.frame toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    if ([self.delegate respondsToSelector:@selector(onDropdownMenuShow)]) {
        [self.delegate onDropdownMenuShow];
    }
}

- (void)dismiss {
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(onDropdownMenuDismiss)]) {
        [self.delegate onDropdownMenuDismiss];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

@end
