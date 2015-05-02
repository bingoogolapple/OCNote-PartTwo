//
//  BGAProductViewController.m
//  Lottery
//
//  Created by bingoogol on 15/4/28.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAProductViewController.h"
#import "BGAProduct.h"
#import "BGAProductCell.h"

@interface BGAProductViewController ()

@property (nonatomic, strong) NSMutableArray *products;

@end

@implementation BGAProductViewController

static NSString * const reuseIdentifier = @"ProductCell";

- (instancetype)init {
    // 创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 每一个cell的尺寸
    layout.itemSize = CGSizeMake(80, 80);
    // 垂直间距
    layout.minimumLineSpacing = 10;
    // 水平间距
    layout.minimumInteritemSpacing = 0;
    // 内边距
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    return [super initWithCollectionViewLayout:layout];
}

- (NSMutableArray *)products {
    if (_products == nil) {
        _products = [NSMutableArray array];
        
        NSString *fileName = [[NSBundle mainBundle] pathForResource:@"products.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:fileName];
        NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in jsonArr) {
            BGAProduct *product = [BGAProduct productWithDict:dict];
            [_products addObject:product];
        }
    }
    return _products;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // self.view和self.collectionView不相等
//    Logger(@"%@----%@", self.view, self.collectionView);
    
    // 注册UICollectionViewCell，如果没有从缓存池找到，就会自动帮我们创建UICollectionViewCell
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    
    // bundle设置nil时，默认为mainbundle
    [self.collectionView registerNib:[UINib nibWithNibName:@"BGAProductCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BGAProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    BGAProduct *product = [self.products objectAtIndex:indexPath.item];
    cell.product = product;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 为应用配置url => Info => URL Types  (Identifier:abc    URL Schemes:mm    mm://abc)
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mm://abc"]];
    
    BGAProduct *product = [self.products objectAtIndex:indexPath.item];
    Logger(@"点击了--》%@", product.title);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@://%@", product.customUrl, product.ID];
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:urlStr];
    // 判断是否安装某个应用
    if (![app canOpenURL:url]) {
        // 没有安装某个应用
        url = [NSURL URLWithString:product.url];
    }
    [[UIApplication sharedApplication] openURL:url];
}


@end
