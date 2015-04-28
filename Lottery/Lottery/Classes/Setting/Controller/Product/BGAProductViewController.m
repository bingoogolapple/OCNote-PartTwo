//
//  BGAProductViewController.m
//  Lottery
//
//  Created by bingoogol on 15/4/28.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAProductViewController.h"

@interface BGAProductViewController ()

@end

@implementation BGAProductViewController

static NSString * const reuseIdentifier = @"ProductCell";

- (instancetype)init {
    // 创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 每一个cell的尺寸
    layout.itemSize = CGSizeMake(75, 75);
    // 垂直间距
    layout.minimumLineSpacing = 10;
    // 水平间距
    layout.minimumInteritemSpacing = 1;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册UICollectionViewCell，如果没有从缓存池找到，就会自动帮我们创建UICollectionViewCell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}


@end
