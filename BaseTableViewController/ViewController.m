//
//  ViewController.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/13.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewCell.h"

#define macro_keywordify @try{} @catch (...){}

#define macro_stringify_(A) #A
#define macro_stringify(A)  macro_stringify_(A)

#define macro_concat_(A,B)  A ## B
#define macro_concate(A,B)  macro_concat_(A,B)


#define macro_weakify(to_weakify) \
  __weak typeof(to_weakify)     macro_concate(to_weakify,__weak) = (to_weakify);

#define macro_strongify(to_strongify) \
__strong typeof(to_strongify)  macro_concate(to_strongify,__strong) = (to_strongify);




@interface ViewController ()

@end

@implementation ViewController

- (void)loadMore:(BOOL)more{
    [self.dataSources addObjectsFromArray:@[@"测试数据",@"测试数据",@"测试数据",@"测试数据",@"测试数据"]];
}

- (Class)cellClassForTable:(UITableView *)table index:(NSIndexPath *)indexPath{
    return [TestTableViewCell class];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    macro_weakify(self);
    
    __strong typeof(self) weakSelf = self;
    __weak   typeof(self) strongSelf = weakSelf;
    
    NSString * macro_concat_(self,__strong) = @"AB";
//    int macro_concate(A,B) = 123;
    
//    macro_weakify(self);

    dispatch_block_t block = ^(){
        
    };
    NSLog(@"%@",@"haha");

//     metamacro_foreach_cxt(rac_weakify_,, __weak, __VA_ARGS__)
//     metamacro_concat(metamacro_foreach_cxt, metamacro_argcount(__VA_ARGS__))(MACRO, SEP, CONTEXT, __VA_ARGS__)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
