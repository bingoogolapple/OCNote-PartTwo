//
//  BGAProfileViewController.m
//  WeiBo
//
//  Created by bingoogol on 15/5/3.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAProfileViewController.h"
#import "BGATest1ViewController.h"
#import "SDWebImageManager.h"

// “duplicate symbol _OBJC_CLASS_$_类名 in:”错误
// 1.90%的 都是因为#import了.m文件
// 2.其他可能是因为项目中存在了2了一样的.m文件


@interface BGAProfileViewController ()

@end

@implementation BGAProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:0 target:self action:@selector(setting)];
    
    // 字节大小
    int byteSize = [SDImageCache sharedImageCache].getSize;
    // M大小
    double size = byteSize / 1000.0 / 1000.0;
    self.navigationItem.title = [NSString stringWithFormat:@"缓存大小(%.1fM)", size];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除缓存" style:0 target:self action:@selector(clearCache)];
    
    [self fileOperation];
}

- (void)fileOperation {
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 缓存路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // caches目录删掉后苹果会再自动生成
    [mgr removeItemAtPath:caches error:nil];
    
    Logger(@"%d", [@"/Users/bingoogol/Desktop/电源键助手" fileSize]);
}

/**
 NSString *filepath = [caches stringByAppendingPathComponent:@"cn.heima.----2-/Cache.db-wal"];
 
 // 获得文件\文件夹的属性(注意:文件夹是没有大小属性的,只有文件才有大小属性)
 NSDictionary *attrs = [mgr attributesOfItemAtPath:filepath error:nil];
 Logger(@"%@ %@", caches, attrs);
 */

- (void)clearCache {
    // 提醒
    UIActivityIndicatorView *circle = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [circle startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:circle];
    
    // 清除缓存
    [[SDImageCache sharedImageCache] clearDisk];
    
    // 显示按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除缓存" style:0 target:self action:@selector(clearCache)];
    self.navigationItem.title = [NSString stringWithFormat:@"缓存大小(0M)"];
}

- (void)setting {
    BGATest1ViewController *test1 = [[BGATest1ViewController alloc] init];
    test1.title = @"test1";
    [self.navigationController pushViewController:test1 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
