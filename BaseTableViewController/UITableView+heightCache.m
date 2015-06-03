//
//  UITableView+heightCache.m
//  BaseTableViewController
//
//  Created by 郑林琴 on 15/6/3.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "UITableView+heightCache.h"
#import <objc/runtime.h>

@implementation UITableView (heightCache)

+ (void)load{
    Method reload = class_getInstanceMethod([self class], @selector(reloadData));
    Method bReload= class_getInstanceMethod([self class], @selector(logReload));
    method_exchangeImplementations(reload, bReload);
}

- (void)logReload{
    NSLog(@"zhenglinqin reload");
    [self logReload];
}

@end


@implementation UITableViewHeightCache



@end
