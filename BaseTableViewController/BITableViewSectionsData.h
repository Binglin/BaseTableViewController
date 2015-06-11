//
//  BITableViewSectionsData.h
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/6/11.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BITableViewSectionsData : NSObject

@property (nonatomic, strong) NSMutableArray *rowDatas;
@property (nonatomic, strong) UIView    *sectionHeaderView;
@property (nonatomic, strong) NSString  *sectionTitle;
@property (nonatomic, assign) CGFloat   sectionHeaderHeight;
@property (nonatomic, assign) CGFloat   sectionFooterHeight;

+ (instancetype)sectionWithRowDatas:(NSArray *)rowDatas;

@end
