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
    [self.dataSources addObjectsFromArray:@[@"xib生成的cell显示example",
                                            @"xib生成的cell显示example",
                                            @"xib生成的",
                                            @"。。。",
                                            @"xib生成的cell显示examplexib生成的cell显示examplexib生成的cell显示example",
                                            @"xib生成的cell显示examplexib生成的cell显示examplexib生成的cell显示example",
                                            @"xib生成的cell显示examplexib生成的cell显示examplexib生成的cell显示example",
                                            @"xib生成的cell显示example",
                                            @"xib生成的cell显示example",
                                            @"xib生成的cell显示example",
                                            @"xib生成的cell显示example",
                                            @"xib生成的cell显示example",
                                            @"xib生成的cell显示examplexib生成的cell显示examplexib生成的cell显示examplexib生成的cell显示examplexib生成的cell"
                                            ]];
}

- (Class)cellClassForTable:(UITableView *)table index:(NSIndexPath *)indexPath{
    return [TestXibTableViewCell class];
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *identifier = @"xibCell";
//    TestXibTableViewCell *codeCell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (codeCell == nil) {
//        UINib *nib = [UINib nibWithNibName:@"TestXibTableViewCell" bundle:nil];
//        [tableView registerNib:nib forCellReuseIdentifier:identifier];
//        codeCell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    }
//    [codeCell setItem:self.dataSources[indexPath.row]];
//    return codeCell;
//}

@end
