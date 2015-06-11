//
//  UITableView+height_cache.h
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/6/11.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (height_cache)

@property (nonatomic, strong)  NSMutableDictionary *heightCache;
@property (nonatomic, assign)  BOOL needCache;

- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;

@end
