//
//  TestXibCellController.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/15.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "TestXibCellController.h"
#import "TestXibTableViewCell.h"


@implementation TestXibCellController

- (void)loadMore:(BOOL)more{
    [self.dataSources addObjectsFromArray:@[@"xib生成的cell显示example",@"xib生成的cell显示example",
                                            @"xib生成的cell显示example",@"xib生成的cell显示example",
                                            @"xib生成的cell显示example",@"xib生成的cell显示example",
                                            @"xib生成的cell显示example",@"xib生成的cell显示example",
                                            @"xib生成的cell显示example",@"xib生成的cell显示example"]];
}

- (Class)cellClassForTable:(UITableView *)table index:(NSIndexPath *)indexPath{
    return [TestXibTableViewCell class];
}

@end
