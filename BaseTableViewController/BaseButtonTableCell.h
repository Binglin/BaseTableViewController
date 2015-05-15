//
//  BaseButtonTableCell.h
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/15.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "BaseTableViewCell.h"

/** 
 *  ~~~~~~~~~~~~~~~~当cell中包含一个button时使用～～～～～～～～～～～～～
 */




@protocol BaseButtonTableCellDelegate <NSObject>
@optional

/**
 *  ~~~~~~~~返回cell中button的tag ～ cell中button有不同tag时适用~~~~~~~
 */
- (void)buttonActionBtnType: (NSInteger)type  data:(id)dataItem;


/**
 *  返回cell的类型（class）及cell的数据cellItem,点击某个特殊类的cell时适用
 */
- (void)buttonActionCellType:(Class)cellClass data:(id)dataItem;
@end



#pragma mark - BaseButtonTableCell
@interface BaseButtonTableCell : BaseTableViewCell

@property (nonatomic, assign) id<BaseButtonTableCellDelegate> viewController;
- (IBAction)buttonActioned:(UIButton *)sender;

@end




/*带一个button的基础类*/
#pragma mark - OneButtonTableViewCell
@interface OneButtonTableViewCell : BaseButtonTableCell

@property (strong, nonatomic,readonly)  UIButton *actionButton;

@end
