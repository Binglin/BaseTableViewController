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
    BITableViewSectionsData *sectionData = self.dataSources[section];
    header.frame = header.frame = ({CGRect frame = header.frame; frame.size.height = sectionData.sectionHeaderHeight;frame;});
}

- (void)configurationFooter:(UIView *)footer inTable:(UITableView *)table section:(NSInteger)section{
    BITableViewSectionsData *sectionData = self.dataSources[section];
    footer.frame = footer.frame = ({CGRect frame = footer.frame; frame.size.height = sectionData.sectionFooterHeight;frame;});
}

- (UITableViewStyle)customStyleForTable:(UITableView *)tableView{
    return UITableViewStyleGrouped;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    BITableViewSectionsData *sectionData = self.dataSources[section];
//    if (sectionData.sectionHeaderView) {
//        return sectionData.sectionHeaderView;
//    }
//    else{
//        return [super tableView:tableView viewForHeaderInSection:section];
//    }
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    BITableViewSectionsData *sectionData = self.dataSources[section];
//    if (sectionData.sectionFooterView) {
//        return sectionData.sectionFooterView;
//    }
//    else{
//        return [super tableView:tableView viewForFooterInSection:section];
//    }
//}

@end
