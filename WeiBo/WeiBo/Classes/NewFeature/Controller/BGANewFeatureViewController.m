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

/*
 一个控件用肉眼看不见，有哪些可能
 1.根本没有创建实例化这个控件
 2.没有设置尺寸
 3.控件的颜色跟父控件的背景颜色一样（实际上已经显示了，只不过用肉眼看不见）
 4.透明度alpha <= 0.01
 5.hidden = YES
 6.没有添加到父控件中
 7.被其他控件挡住了
 8.位置不对
 9.父控件发生了以上情况
 10.特殊情况：
    UIImageView没有设置image属性，或者设置图片名不对
    UILabel没有设置文字，或者文字颜色和父控件的背景色一样
    UITextField没有设置文字，或者没有设置边框样式borderStyle
    UIPageControl没有设置总页数，不会显示小圆点
    UIButton内部imageView和titleLabel的frame被篡改，或者imageView和titleLabel没有内容
 
 添加一个控件的建议（调试技巧）：
 1.最好设置背景色和尺寸
 2.控件的颜色尽量不要跟父控件的背景色一样
 */
@implementation BGANewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
    [self setupPageControl];
}

- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < BGANewFeatureCount; i++) {
        /*
         程序启动会自动加载叫做Default.png的图片
         3.5inch retina屏幕：Default@2x.png
         3.5inch 非retina屏幕：Default.png
         4inch retina屏幕：Default-568h@2x.png
         只有程序启动时自动去加载的图片才会自动查找-568h@2x.png，在新特新界面需要程序员通过xcode手动设置Retina 4-inch
         */
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        
        if (i == BGANewFeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
        
    }
    // scrollView中会有其他默认的子控件(例如滚动条等)，不能通过[scrollView.subviews lastObject];来获取最后一页
    
    scrollView.contentSize = CGSizeMake(BGANewFeatureCount * scrollW, 0);
    // 去处弹簧效果
    scrollView.bounces = NO;
    // 启用分页效果
    scrollView.pagingEnabled = YES;
    // 取消水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
}

- (void)setupLastImageView:(UIImageView *)imageView {
    // 开启交互功能，否则子控件不能点击
    imageView.userInteractionEnabled = YES;
    
    // 1.分享给大家
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [shareBtn addTarget:self action:@selector(onClickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.width = 160;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.65;
    [imageView addSubview:shareBtn];
    
//    shareBtn.backgroundColor = [UIColor redColor];
//    shareBtn.imageView.backgroundColor = [UIColor blueColor];
//    shareBtn.titleLabel.backgroundColor = [UIColor yellowColor];
    // EdgeInsets:自切
    // contentEdgeInsets:会影响按钮内部的所有内容（imageView，titleLabel）
//    shareBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 100, 0, 0);
    
//    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    
    // 2.开始微博
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    startBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [startBtn addTarget:self action:@selector(onClickStartBtn:) forControlEvents:UIControlEventTouchUpInside];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    [imageView addSubview:startBtn];
    
}

- (void)onClickShareBtn:(UIButton *)shareBtn {
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)onClickStartBtn:(UIButton *)startBtn {
    
}

- (void)setupPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = BGANewFeatureCount;
    // 取消用户交互，或者设置宽、高为0也可以达到取消用户交互的目的，同时也就取消了子控件的用户交互
    //    pageControl.userInteractionEnabled = NO;
    // 就算没有设置尺寸，里面的内容还是可以照常显示的
    //    pageControl.width = 100;
    //    pageControl.height = 50;
    // 没有尺寸背景色也就看不见了
    //    pageControl.backgroundColor = [UIColor redColor];
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height - 50;
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