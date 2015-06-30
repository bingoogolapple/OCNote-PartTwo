//
//  BGAAvatarView.m
//  WeiBo
//
//  Created by bingoogol on 15/6/30.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAAvatarView.h"
#import "BGAUser.h"
#import "UIImageView+WebCache.h"

@interface BGAAvatarView()

@property (nonatomic, weak) UIImageView *verifiedView;

@end

@implementation BGAAvatarView

- (UIImageView *)verifiedView {
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        _verifiedView = verifiedView;
    }
    return _verifiedView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setUser:(BGAUser *)user {
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    switch (user.verified_type) {
        case BGAUserVerifiedPersonal: // 个人认证
        self.verifiedView.hidden = NO;
        self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
        break;
        
        case BGAUserVerifiedOrgEnterprice:
        case BGAUserVerifiedOrgMedia:
        case BGAUserVerifiedOrgWebsite: // 官方认证
        self.verifiedView.hidden = NO;
        self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
        break;
        
        case BGAUserVerifiedDaren: // 微博达人
        self.verifiedView.hidden = NO;
        self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
        break;
        
        default:
        self.verifiedView.hidden = YES; // 当做没有任何认证
        break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_verifiedView && !_verifiedView.hidden) {
        _verifiedView.size = self.verifiedView.image.size;
        CGFloat scale = 0.6;
        _verifiedView.x = self.width - self.verifiedView.width * scale;
        _verifiedView.y = self.height - self.verifiedView.height * scale;
    }
}

@end
