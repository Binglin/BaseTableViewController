//
//  SectionsTableViewController.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/6/11.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "SectionsTableViewController.h"
#import "UIViewController+header_footer.h"


@implementation SectionsTableViewController

- (id)dataAtIndexPath:(NSIndexPath *)indexPath{
    BITableViewSectionsData *sectionData = self.dataSources[indexPath.section];
    return sectionData.rowDatas[indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BITableViewSectionsData *sectionData = self.dataSources[section];
    return [sectionData.rowDatas count];
}

- (void)configurationHeader:(UIView *)header inTable:(UITableView *)table section:(NSInteger)section{
    
}

- (void)configurationFooter:(UIView *)footer inTable:(UITableView *)table section:(NSInteger)section{
    
}

- (UITableViewStyle)customStyleForTable:(UITableView *)tableView{
    return UITableViewStyleGrouped;
}

@end
