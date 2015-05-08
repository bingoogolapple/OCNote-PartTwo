//
//  BGANewFeatureViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/5/8.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGANewFeatureViewController.h"

#define BGANewFeatureCount 4

@interface BGANewFeatureViewController()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation BGANewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < BGANewFeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
    }
    scrollView.contentSize = CGSizeMake(BGANewFeatureCount * scrollW, 0);
    // 去处弹簧效果
    scrollView.bounces = NO;
    // 启用分页效果
    scrollView.pagingEnabled = YES;
    // 取消水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = BGANewFeatureCount;
    // 取消用户交互，或者设置宽、高为0也可以达到取消用户交互的目的，同时也就取消了子控件的用户交互
//    pageControl.userInteractionEnabled = NO;
    // 就算没有设置尺寸，里面的内容还是可以照常显示的
//    pageControl.width = 100;
//    pageControl.height = 50;
    // 没有尺寸背景色也就看不见了
//    pageControl.backgroundColor = [UIColor redColor];
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    pageControl.currentPageIndicatorTintColor = BGAColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = BGAColor(189, 189, 189);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float page = scrollView.contentOffset.x / scrollView.width;
    // 加0.5强转成整数，四舍五入
    self.pageControl.currentPage = (int)(page + 0.5);
    
    Logger(@"%@--%d", NSStringFromCGPoint(scrollView.contentOffset), self.pageControl.currentPage);
}

@end