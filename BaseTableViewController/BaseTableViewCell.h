//
//  BaseTableViewCell.h
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/13.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+data_set.h"

/**
 *  lineView 主要是适配iOS6时使用，iOS6无法设置线条右边的inset距离
 */
#pragma mark - BaseTableViewCell
@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, assign) id cellItem;

@property (nonatomic, assign) UIEdgeInsets lineInset;

//cell底部的线条
@property (nonatomic, assign) BOOL lineHide;

@property (nonatomic, strong, readonly) UIView *lineView;

/** ##### warning #####请勿重写initWithStyle:(UITableViewCellStyle)style
                        reuseIdentifier:(NSString *)reuseIdentifier
 
 *  cell的initWithStyle:方法及initWithCoder均调用的方法
 *  ~~~~~~子类添加view方法~~~~~~请在此方法中添加子view，不要复写initWithStyle:方法
 */
- (void)subclassInitializeViews;

/***  使用autolayout时 设置constraints */
- (void)setUpconstraints;

@end
