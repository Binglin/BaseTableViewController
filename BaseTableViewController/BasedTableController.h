//
//  BasedTableController.h
//
//  Created by Zhenglinqin on 15/3/9.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+data_set.h"


#pragma mark ~~~~~~~~~~~~~~~~~~~~~~
#pragma mark - BasedTableController
@interface BasedTableController : UIViewController

@property (nonatomic, strong)           NSMutableArray  *dataSources;
@property (nonatomic, strong,readonly)  UITableView     *tableView;


/**table View Style*/
#pragma mark - table View Style
- (UITableViewStyle)customStyleForTable:(UITableView *)tableView;


/**
 *  获取dataSources的数据 网络请求加载数据也写在此方法
 *  静态数据最好也是在本方法设置，看起来会比较统一
 *  more YES 加载更多
 */
- (void)loadMore:(BOOL)more;

- (id)dataAtIndexPath:(NSIndexPath *)indexPath;
- (void)appendDataWith:(NSArray *)datas withMore:(BOOL)more;
@end










