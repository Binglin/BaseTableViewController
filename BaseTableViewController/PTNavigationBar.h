//
//  PTNavigationBar.h
//  BaseTableViewController
//
//  Created by 郑林琴 on 15/6/14.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger, PTNavigationBarType) {
    PTNavigationBar_left  = 1 << 0,
    PTNavigationBar_right = 1 << 1
};


@protocol PTNavigationBarDelegate <NSObject>

- (void)navigationButtonAction:(PTNavigationBarType)type;

@end


//project top navigation bar
@interface PTNavigationBar : UIView

@property (nonatomic, strong,readonly) UIButton *leftButton;
@property (nonatomic, strong,readonly) UIButton *rightButton;

@property (nonatomic, assign) id<PTNavigationBarDelegate> delegate;

@property (nonatomic, copy) NSString *title;

@end
