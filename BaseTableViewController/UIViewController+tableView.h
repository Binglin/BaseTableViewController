//
//  UIViewController+tableView.h
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/6/12.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIViewController_tableView

#define UIViewController_table_section_data


#ifdef UIViewController_table_section_data
#import "BITableViewSectionsData.h"
#endif



#pragma mark - UIViewController (tableView)
@interface UIViewController (tableView)


@property (nonatomic, strong)           NSMutableArray  *dataSources;
@property (nonatomic, strong,readonly)  UITableView     *tableView;


/**table View Style*/
#pragma mark  table View Style
- (UITableViewStyle)customStyleForTable:(UITableView *)tableView;

- (void)initialTableView;
- (void)initialTableViewWithStyle:(UITableViewStyle)style;

- (CGRect)initialframeForTable;

@end
#pragma mark -



#pragma mark - UIViewController (table_data)
@interface UIViewController (table_data)

/**
 *  获取dataSources的数据 网络请求加载数据也写在此方法
 *  静态数据最好也是在本方法设置，看起来会比较统一
 *  more YES 加载更多
 */
- (void)loadMore:(BOOL)more;

/**
 *  section == 1的方法
 */
- (id)dataAtIndexPath:(NSIndexPath *)indexPath;
- (void)appendDataWith:(NSArray *)datas withMore:(BOOL)more;

/**
 *  section > 1使用的方法 sectionData为 BITableViewSectionsData
 */
#ifdef UIViewController_table_section_data
- (BITableViewSectionsData *)sectionDataAtSection:(NSInteger)section;
- (id)sectionRowDataAtIndexPath:(NSIndexPath *)indexPath;
- (void)appendSectionsData:(NSArray *)sectionsData withMore:(BOOL)more;
#endif


@end
#pragma mark -




#pragma mark - UIViewController (cell)
@interface UIViewController (cell)


#pragma mark  cell  class or nib register

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
#pragma mark -

