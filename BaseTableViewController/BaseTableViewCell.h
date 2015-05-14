//
//  BaseTableViewCell.h
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/13.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TableViewCellDelegate <NSObject>
@required
//cell设置数据的方法
- (void)setItem:(id)item;
@optional
+ (CGFloat)heightForItem:(id)item;

@end


@interface BaseTableViewCell : UITableViewCell<TableViewCellDelegate>

//cell所存储的数据
@property (nonatomic, assign) id cellItem;

@property (nonatomic, assign) UIEdgeInsets lineInset;

//cell底部的线条
@property (nonatomic, assign) BOOL lineHide;
@property (nonatomic, strong, readonly) UIView *lineView;


- (void)setItem:(id)item;

//cell的initWithStyle:方法及initWithCoder均调用的方法
//子类页面配置
- (void)subViewConfig;


@end
