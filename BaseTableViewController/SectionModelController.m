//
//  SectionModelController.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/6/11.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "SectionModelController.h"
#import "ViewControllerCell.h"
#import "UIViewController+header_footer.h"

@implementation SectionModelController



- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self registerHeaderFooter:self.tableView];
}

- (void)loadMore:(BOOL)more{
    [self appendDataWith:[self getData] withMore:more];
}

- (NSArray *)getData{
    NSInteger count = self.dataSources.count;
    NSMutableArray *sectionDatas = [NSMutableArray new];
    for (int section = count; section < count + 3; section ++) {
        NSMutableArray *rowArr = [NSMutableArray arrayWithCapacity:4];
        for (int row = 0; row  < 4; row ++) {
            [rowArr addObject:[NSString stringWithFormat:@"section%d row%d",section,row]];
        }
        BITableViewSectionsData *sectionData = [BITableViewSectionsData sectionWithRowDatas:rowArr];
        sectionData.sectionTitle = [NSString stringWithFormat:@"section = %d",section];
        sectionData.sectionHeaderHeight = 40.f;
        sectionData.sectionFooterHeight = 20.f;
        [sectionDatas addObject:sectionData];
    }
    return sectionDatas;
}

- (Class)cellClassForTable:(UITableView *)table index:(NSIndexPath *)indexPath{
    return [ViewControllerCell class];
}

- (void)configurationHeader:(UITableViewHeaderFooterView *)header inTable:(UITableView *)table section:(NSInteger)section{
    [super configurationHeader:header inTable:table section:section];
    header.contentView.backgroundColor = [UIColor redColor];
    BITableViewSectionsData *data = self.dataSources[section];
    header.textLabel.text  = data.sectionTitle;
}

- (void)configurationFooter:(UITableViewHeaderFooterView *)footer inTable:(UITableView *)table section:(NSInteger)section{
    footer.contentView.backgroundColor = [UIColor clearColor];
}

- (Class)headerFooterClassForTable:(UITableView *)table inSection:(NSInteger)section type:(TableHeaderFooterType)headerOrFooter{
    return [UITableViewHeaderFooterView class];
}

- (UITableViewStyle)customStyleForTable:(UITableView *)tableView{
    return UITableViewStyleGrouped;
}


@end
