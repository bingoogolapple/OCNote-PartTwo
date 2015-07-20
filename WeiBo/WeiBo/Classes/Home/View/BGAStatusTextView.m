//
//  BGAStatusTextView.m
//  WeiBo
//
//  Created by bingoogol on 15/7/20.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAStatusTextView.h"
#import "BGASpecial.h"

#define BGAStatusTextViewCoverTag 999

@implementation BGAStatusTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textContainerInset = UIEdgeInsetsZero;
        self.backgroundColor = [UIColor clearColor];
        self.editable = NO;
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        // 禁止滚动, 让文字完全显示出来
        self.scrollEnabled = NO;
        
//        self.userInteractionEnabled = NO;
    }
    return self;
}

- (BGASpecial *)touchingSpecialWithPoint:(CGPoint)point {
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (BGASpecial *special in specials) {
        for (NSValue *rectValue in special.rects) {
            if (CGRectContainsPoint(rectValue.CGRectValue, point)) {
                return special;
            }
        }
    }
    return nil;
}

- (void)setupSpecialRects {
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (BGASpecial *special in specials) {
        self.selectedRange = special.range;
        // self.selectedRange --影响--> self.selectedTextRange
        // 获得选中范围的矩形框
        NSArray *selectionRects = [self selectionRectsForRange:self.selectedTextRange];
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        
        NSMutableArray *rects = [NSMutableArray array];
        for (UITextSelectionRect *selectionRect in selectionRects) {
            CGRect rect = selectionRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0) continue;
            
            [rects addObject:[NSValue valueWithCGRect:rect]];
        }
        special.rects = rects;
    }
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setupSpecialRects];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 触摸对象
    UITouch *touch = [touches anyObject];
    // 触摸点
    CGPoint point = [touch locationInView:self];
    // 根据触摸点获取被触摸的特殊字符串
    BGASpecial *special = [self touchingSpecialWithPoint:point];
    // 在触摸的特殊字符串后面显示一段高亮的背景
    for (NSValue *rectValue in special.rects) {
        UIView *cover = [[UIView alloc] init];
        cover.backgroundColor = [UIColor greenColor];
        cover.frame = rectValue.CGRectValue;
        cover.tag = BGAStatusTextViewCoverTag;
        cover.layer.cornerRadius = 5;
        [self insertSubview:cover atIndex:0];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // 去掉特殊字符串后面的高亮背景
    for (UIView *child in self.subviews) {
        if (child.tag == BGAStatusTextViewCoverTag) [child removeFromSuperview];
    }
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    return [super hitTest:point withEvent:event];
//}

/**
 告诉系统触摸点point是否在这个UI控件身上
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // 根据触摸点获取被触摸的特殊字符串
    BGASpecial *special = [self touchingSpecialWithPoint:point];
    if (special) {
        return YES;
    } else {
        return NO;
    }
}

// 触摸事件的处理
// 1.判断点在谁身上：调用- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
// 2.pointInside返回YES的控件就是触摸点所在的UI控件
// 3.由触摸点所在的UI控件选出处理事件的UI控件：调用- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event

@end
