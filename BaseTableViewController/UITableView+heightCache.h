//
//  UITableView+heightCache.h
//  BaseTableViewController
//
//  Created by 郑林琴 on 15/6/3.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (heightCache)


@end


@interface UITableViewHeightCache : NSCache

- (void   )cacheHeight:(CGFloat)height forIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;
- ( BOOL  )hasCacheForIndexPath:(NSIndexPath *)indexPath;

@end
