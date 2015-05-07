//
//  BGADropdownMenu.h
//  WeiBo
//
//  Created by bingoogol on 15/5/5.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BGADropdownMenu;

@protocol BGADropdownMenuDelegate <NSObject>

@optional
- (void)onDropdownMenuDismiss:(BGADropdownMenu *)menu;
- (void)onDropdownMenuShow:(BGADropdownMenu *)menu;;

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

@property (nonatomic, weak) id<BGADropdownMenuDelegate> delegate;

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