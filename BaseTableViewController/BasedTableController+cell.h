//
//  BasedTableController+cell.h
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/6/11.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "BasedTableController.h"

@interface BasedTableController (cell)


#pragma mark - cell  class or nib register

/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  cell的class
 *  default is UITableViewCell for cellClass  and UITableHeaderFooterView for headerFooterClass
 */
- (Class) cellClassForTable:(UITableView *)table index:(NSIndexPath *)indexPath;

/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  在view view Controller初始化完成后即注册nib 或者 cell Nib Or Class
 *  @param tableView self.tableView已调用此方法
 */
- (void)register_cell:(UITableView *)tableView;

/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  基础类未实现，如果子类实现 则表示为多种类cell
 *  @return 所有cell种类数组
 */
- (NSArray*)cellClassesForTable:(UITableView *)tableView;


@end
