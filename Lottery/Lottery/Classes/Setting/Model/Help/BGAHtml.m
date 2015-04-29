//
//  BGAHtml.m
//  Lottery
//
//  Created by bingoogol on 15/4/29.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAHtml.h"

@implementation BGAHtml

+ (instancetype)htmlWithDict:(NSDictionary *)dict {
    BGAHtml *html = [[BGAHtml alloc] init];
    
    html.title = dict[@"title"];
    html.html = dict[@"html"];
    html.ID = dict[@"id"];
    
    return html;
}

@end
