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


IB_DESIGNABLE
//project top navigation bar
@interface PTNavigationBar : UIView

@property (nonatomic, strong,readonly) UIButton *leftButton;
@property (nonatomic, strong,readonly) UIButton *rightButton;


//IBInspectable
@property (nonatomic, assign) IBInspectable BOOL leftButtonHide;
@property (nonatomic, assign) IBInspectable BOOL rightButtonHide;

@property (nonatomic, strong) IBInspectable UIImage *leftNormalImage;
@property (nonatomic, strong) IBInspectable UIImage *leftSelectImage;

@property (nonatomic, strong) IBInspectable UIImage *rightNormalImage;
@property (nonatomic, strong) IBInspectable UIImage *rightSelectImage;




//使用xib添加PTNavigationBar时需要连接delegate到files owner
@property (nonatomic, assign) IBOutlet id<PTNavigationBarDelegate> delegate;

@property (nonatomic, copy) IBInspectable NSString *title;

@end
