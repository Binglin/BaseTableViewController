//
//  ViewController.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/13.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerCell.h"
#import "UIViewController+transitionFunc.h"
#import "UITableView+heightCache.h"




/* macro_weakify(self);
 
 NSString * macro_concate(self,abs) = @"AB";
 
 dispatch_block_t block = ^(){
 macro_strongify(self);
 
 };*/


@interface ViewController ()

@property (nonatomic, strong) NSString *testCopys;

@end

@implementation ViewController

- (void)loadMore:(BOOL)more{
    [self.dataSources addObjectsFromArray:@[@"TestCodeCellController",
                                            @"TestXibCellController"]];
    
    
    
}

- (Class)cellClassForTable:(UITableView *)table index:(NSIndexPath *)indexPath{
    return [ViewControllerCell class];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *vcClassName = [self dataAtIndexPath:indexPath];
    [self pushVCClass:NSClassFromString(vcClassName)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableViewHeightCache *cache = [UITableViewHeightCache new];
    NSMutableDictionary *dic_cache = [NSMutableDictionary new];
    NSMutableArray *arr_cache = @[].mutableCopy;
    CFMutableDictionaryRef cgDic = cg
    
    [cache setObject:@"111" forKey:[NSIndexPath indexPathForRow:0 inSection:0]];
    [dic_cache setObject:@"111" forKey:[NSIndexPath indexPathForRow:0 inSection:0]];
    [arr_cache addObject:@[@"111"].mutableCopy];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    
    CFDictionaryAddValue(<#CFMutableDictionaryRef theDict#>, <#const void *key#>, <#const void *value#>)
    
    NSInteger times = 10000000;
    NSLog(@"cache");
    [self time:^{
        for (int i = 0; i < times; i ++) {
//            [cache setObject:@"111" forKey:indexPath];
            id indexObject = [cache objectForKey:indexPath];
        }
    }];
    
    
    NSLog(@"dic");
    [self time:^{
        for (int i = 0; i < times; i ++) {
//            [dic_cache setObject:@"111" forKey:indexPath];
            id indexDic    = [dic_cache objectForKey:indexPath];
        }
    }];
    
    
    NSLog(@"arr");
    [self time:^{
        for (int i = 0; i < times; i ++) {
//            arr_cache[indexPath.section][indexPath.row] = @"111";
            id indexArr = arr_cache[indexPath.section][indexPath.row];
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)time:(dispatch_block_t)block_t{
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    if (block_t) {
        block_t();
    }
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSLog(@"%f",end - start);
}

@end
