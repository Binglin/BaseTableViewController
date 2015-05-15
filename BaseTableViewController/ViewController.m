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

#define macro_keywordify try{} @catch (...){}

#define macro_stringify_(A) #A
#define macro_stringify(A)  macro_stringify_(A)

#define macro_concat_(A,B)  A ## B
#define macro_concate(A,B)  macro_concat_(A,B)



#define macro_weakify(to_weakify)   \
__weak typeof(to_weakify)     macro_concat_(to_weakify,__weak) = (to_weakify);

#define macro_strongify(to_strongify) \
__strong typeof(to_strongify)  macro_concat_(to_strongify,__strong) = macro_concat_(to_strongify,__weak);


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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
