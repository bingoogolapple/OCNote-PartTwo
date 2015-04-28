//
//  BGAProductCell.m
//  Lottery
//
//  Created by bingoogol on 15/4/28.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAProductCell.h"
#import "BGAProduct.h"

@interface BGAProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end


@implementation BGAProductCell

- (void)awakeFromNib {
    _imageView.layer.cornerRadius = 10;
    _imageView.clipsToBounds = YES;
}

- (void)setProduct:(BGAProduct *)product {
    _product = product;
    _imageView.image = [UIImage imageNamed:product.icon];
    _label.text = product.title;
}

@end
