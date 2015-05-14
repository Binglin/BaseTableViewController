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
-(Class) cellClassForTable:(UITableView *)table index:(NSIndexPath *)indexPath;

/**
 *  获取dataSources的数据 网络请求加载数据也写在此方法
 *  静态数据最好也是在本方法设置，看起来会比较统一
 *  more YES 加载更多
 */
- (void)loadMore:(BOOL)more;


@end





