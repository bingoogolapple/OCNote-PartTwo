//
//  BGAEmotion.m
//  WeiBo
//
//  Created by bingoogol on 15/7/17.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAEmotion.h"
#import "MJExtension.h"

@interface BGAEmotion ()<NSCoding>

@end

@implementation BGAEmotion


MJCodingImplementation
/**
 *  从文件中解析对象时调用
 */
//- (id)initWithCoder:(NSCoder *)decoder
//{
//    if (self = [super init]) {
//        self.chs = [decoder decodeObjectForKey:@"chs"];
//        self.png = [decoder decodeObjectForKey:@"png"];
//        self.code = [decoder decodeObjectForKey:@"code"];
//    }
//    return self;
//}
//
///**
// *  将对象写入文件的时候调用
// */
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:self.chs forKey:@"chs"];
//    [encoder encodeObject:self.png forKey:@"png"];
//    [encoder encodeObject:self.code forKey:@"code"];
//}

/**
 *  常用来比较两个BGAEmotion对象是否一样
 *
 *  @param other 另外一个BGAEmotion对象
 *
 *  @return YES : 代表2个对象是一样的，NO: 代表2个对象是不一样
 */
- (BOOL)isEqual:(BGAEmotion *)other {
    //    if (self == other) {
    //        return YES;
    //    } else {
    //        return NO;
    //    }
    
    //    Logger(@"%@--isEqual---%@", self.chs, other.chs);
    
    //    NSString *str1 = @"jack";
    //    NSString *str2 = [NSString stringWithFormat:@"jack"];
    //
    //    str1 == str2 // no
    //    [str1 isEqual:str2]; // NO
    //    [str1 isEqualToString:str2] // YES
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}
@end
