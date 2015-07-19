//
//  BGAEmotionTextView.m
//  WeiBo
//
//  Created by bingoogol on 15/7/18.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAEmotionTextView.h"
#import "BGAEmotion.h"
#import "BGAEmotionAttachment.h"

@implementation BGAEmotionTextView

- (void)insertEmotion:(BGAEmotion *)emotion {
    if (emotion.code) {
        // insertText : 将文字插入到光标所在的位置
        [self insertText:emotion.code.emoji];
    } else if (emotion.png) {
        // 加载图片
        BGAEmotionAttachment *attch = [[BGAEmotionAttachment alloc] init];
        attch.emotion = emotion;
        
        CGFloat attchWH = self.font.lineHeight;
        Logger(@"attchWH = %f", attchWH);
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);
        
        // 根据附件创建一个属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        
        // 插入属性文字到光标位置
        [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            // 设置字体
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
        
        [BGANotificationCenter postNotificationName:UITextViewTextDidChangeNotification object:self];
    }
}

- (NSString *)fullText {
    NSMutableString *fullText = [NSMutableString string];
    
    // 遍历所有的属性文字（图片、emoji、普通文字）
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        // 如果是图片表情
        BGAEmotionAttachment *attch = attrs[@"NSAttachment"];
        if (attch) {
            // 图片
            Logger(@"附件");
            [fullText appendString:attch.emotion.chs];
        } else {
            Logger(@"普通");
            // emoji、普通文本
            // 获得这个范围内的文字
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
    
    return fullText;
}

@end
