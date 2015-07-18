//
//  BGAEmotionListView.m
//  WeiBo
//
//  Created by bingoogol on 15/7/17.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAEmotionListView.h"
#import "BGAEmotionPageView.h"

@interface BGAEmotionListView() <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation BGAEmotionListView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 1.UIScollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.bounces = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        // 去除滚动条，否则会多创建两个UIImageView滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.userInteractionEnabled = NO;
        // 设置内部的圆点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

// 根据emotions，创建对应个数的表情
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    NSUInteger pageCount = (emotions.count - 1) / BGAEmotionPageSize + 1;
    
    // 1.设置页数
    self.pageControl.numberOfPages = pageCount;
    
    // 2.创建用来显示每一页表情的控件
    for (int i = 0; i < self.pageControl.numberOfPages; i++) {
        BGAEmotionPageView *pageView = [[BGAEmotionPageView alloc] init];
        
        // 计算这一页的表情范围
        NSRange range;
        range.location = i * BGAEmotionPageSize;
        // left：剩余的表情个数（可以截取的）
        NSUInteger left = emotions.count - range.location;
        if (left >= BGAEmotionPageSize) {
            // 这一页足够20个
            range.length = BGAEmotionPageSize;
        } else {
            range.length = left;
        }
        // 设置这一页的表情
        pageView.emotions = [emotions subarrayWithRange:range];
        
        [self.scrollView addSubview:pageView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 1.pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    
    // 3.设置scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i<count; i++) {
        BGAEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    
    // 4.设置scrollView的contentSize才能滚动
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
}

@end