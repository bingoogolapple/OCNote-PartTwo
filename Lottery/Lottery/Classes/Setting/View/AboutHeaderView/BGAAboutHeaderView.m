//
//  BGAAboutHeaderView.h
//  Lottery
//
//  Created by bingoogol on 15/4/26.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAAboutHeaderView.h"

@implementation BGAAboutHeaderView

+ (instancetype)headerView
{
    return [[NSBundle mainBundle] loadNibNamed:@"BGAAboutHeaderView" owner:nil options:nil][0];
}
@end
