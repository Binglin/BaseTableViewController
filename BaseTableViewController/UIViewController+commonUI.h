//
//  UIViewController+commonUI.h
//  BaseTableViewController
//
//  Created by 郑林琴 on 15/6/14.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>



#define UIViewController_commonUI

#import "PTNavigationBar.h"


@interface UIViewController (commonUI)

@end


@interface UIViewController (navigator)

/***  default to YES*/
- (BOOL)needNavigatorBar;

@property (nonatomic, strong) PTNavigationBar *navigatorBar;

- (IBAction)nav_leftAction;

- (IBAction)nav_rightAction;

@end

