//
//  TestCodeCellController.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/15.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "TestCodeCellController.h"
#import "TestCodeTableViewCell.h"

@implementation TestCodeCellController

- (void)loadMore:(BOOL)more{
    [self.dataSources addObjectsFromArray:@[@"代码写的cell显示",@"代码写的cell显示",@"代码写的cell显示",
                                            @"代码写的cell显示",@"代码写的cell显示",@"代码写的cell显示",
                                            @"代码写的cell显示",@"代码写的cell显示",@"代码写的cell显示"]];
}

- (Class)cellClassForTable:(UITableView *)table index:(NSIndexPath *)indexPath{
    return [TestCodeTableViewCell class];
}

@end
