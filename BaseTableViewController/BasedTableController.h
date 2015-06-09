//
//  BasedTableController.h
//
//  Created by Zhenglinqin on 15/3/9.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -



#pragma mark -
@interface BasedTableController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)           NSMutableArray  *dataSources;
@property (nonatomic, strong,readonly)  UITableView     *tableView;

/** cell的class*/
- (Class) cellClassForTable:(UITableView *)table index:(NSIndexPath *)indexPath;

/**
 *  在view view Controller初始化完成后即注册nib 或者 cell
 *
 *  @param tableView self.tableView已调用此方法
 */
- (void)registerNibOrClass:(UITableView *)tableView;

/**
 *  基础类未实现，如果子类实现 则表示为多种类cell
 *
 *  @return 所有cell种类数组
 */
- (NSArray*)cellClassesForTable:(UITableView *)table;


/**
 *  获取dataSources的数据 网络请求加载数据也写在此方法
 *  静态数据最好也是在本方法设置，看起来会比较统一
 *  more YES 加载更多
 */
- (void)loadMore:(BOOL)more;

- (id)dataAtIndexPath:(NSIndexPath *)indexPath;

@end





@interface UITableView (heightCache)

@property (nonatomic, strong)  NSMutableDictionary *heightCache;
@property (nonatomic, assign)  BOOL needCache;

- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;

@end





