//
//  UIViewController+header_footer.h
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/6/11.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>


#define UIViewController_Header_footer_category

typedef enum : NSUInteger {
    TableHeaderFooter_header ,
    TableHeaderFooter_footer
} TableHeaderFooterType;
/**
 *  UITableView Header Footer高度设置及view返回
 */

@interface UITableViewHeaderFooterView (setItem)

- (void)setHeaderItem:(id)item;
- (void)setFooterItem:(id)item;

@end


typedef void(^HeaderFooterConfiguration)(id view);



@interface UIViewController (header_footer)<UITableViewDelegate>

- (void)configurationHeader:(UIView *)header inTable:(UITableView *)table section:(NSInteger)section;
- (void)configurationFooter:(UIView *)footer inTable:(UITableView *)table section:(NSInteger)section;

//when headerFooterForTable return nil,@return not nil , assume that the header and footer in same style
//default is nil
- (Class)headerFooterClassForTable:(UITableView *)table
                         inSection:(NSInteger)section
                              type:(TableHeaderFooterType)headerOrFooter;

- (NSArray *)headerFooterForTable:(UITableView *)tableView;

//BasedTableController 中已调用
- (void)registerHeaderFooter:(UITableView *)tableView;


@end
