//
//  UITableViewCell+data_set.h
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/15.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - UITableViewCell (data_set) cell设置数据方法,cell的高度设置
@interface UITableViewCell (data_set)

/**
 *  判断是否有使用AutoLayout;
 */
+ (NSNumber *)usedAutoLayout;
+ (void)setUsedAutoLayout:(NSNumber *)isUsed;

//cell所存储的数据 使用runtime设置，断点时无法查看到cellItem的数据
@property (nonatomic, assign, readonly) id cellItem;

//计算cell的高度
//或者某个table有多个自定义cell 且高度不同时 用此方法返回高度，以减少if else之类的判断
+ (CGFloat)heightForItem:(id)object;
//cell为固定高度
+ (CGFloat)fixHeightForItem:(id)object;

//cell界面设置写在此方法中,这里默认设置数据item到cellItem,子类不调用super方法,则不会设置数据
- (void)setItem:(id)item;

//dequeueReusableCellWithIdentifier
+ (instancetype)dequeueResuableCellWithTableView:(UITableView *)tableView;


@end
