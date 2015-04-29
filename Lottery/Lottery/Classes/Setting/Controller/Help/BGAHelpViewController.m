//
//  BGAHelpViewController.m
//  Lottery
//
//  Created by bingoogol on 15/4/29.
//  Copyright (c) 2015年 bingoogolapple. All rights reserved.
//

#import "BGAHelpViewController.h"
#import "BGASettingArrowItem.h"
#import "BGASettingGroup.h"
#import "BGAHtml.h"
#import "BGAHtmlViewController.h"
#import "BGANavigationController.h"

@interface BGAHelpViewController ()
@property (nonatomic, strong) NSMutableArray *htmls;
@end

@implementation BGAHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup0];
}

- (NSMutableArray *)htmls {
    if (_htmls == nil) {
        _htmls = [NSMutableArray array];
        
        NSString *fileName = [[NSBundle mainBundle] pathForResource:@"help.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:fileName];
        NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in jsonArr) {
            BGAHtml *html = [BGAHtml htmlWithDict:dict];
            [_htmls addObject:html];
        }
    }
    return _htmls;
}

- (void)addGroup0 {
    NSMutableArray *items = [NSMutableArray array];
    for (BGAHtml *html in self.htmls) {
        BGASettingArrowItem *item = [BGASettingArrowItem itemWithIcon:nil title:html.title destVcClass:nil];
        [items addObject:item];
    }
    BGASettingGroup *group0 = [[BGASettingGroup alloc] init];
    group0.items = items;
    [self.dataList addObject:group0];
}

// 重写父类的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BGAHtml *html = self.htmls[indexPath.row];;
    BGAHtmlViewController *htmlVc = [[BGAHtmlViewController alloc] init];
    htmlVc.html = html;
    htmlVc.title = html.title;
    BGANavigationController *navVc = [[BGANavigationController alloc] initWithRootViewController:htmlVc];
    [self presentViewController:navVc animated:YES completion:nil];
}

@end
