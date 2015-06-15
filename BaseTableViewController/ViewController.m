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
                                            @"TestXibCellController",
                                            @"SectionModelController",
                                            @"CellIdentifierRegisterController"]];
    
    
    
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

- (void)time:(dispatch_block_t)block_t{
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    if (block_t) {
        block_t();
    }
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSLog(@"%f",end - start);
}

@end
