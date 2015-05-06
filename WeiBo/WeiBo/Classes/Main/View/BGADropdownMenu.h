//
//  BGADropdownMenu.h
//  WeiBo
//
//  Created by bingoogol on 15/5/5.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BGADropdownMenuDelegate <NSObject>

- (void)onDropdownMenuDismiss;
- (void)onDropdownMenuShow;

@end


@interface BGADropdownMenu : UIView

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;

@property (nonatomic, strong) id<BGADropdownMenuDelegate> delegate;

+ (instancetype)menu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁
 */
- (void)dismiss;

@end