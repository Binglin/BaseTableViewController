//
//  UIViewController+commonUI.m
//  BaseTableViewController
//
//  Created by 郑林琴 on 15/6/14.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "UIViewController+commonUI.h"
#import <objc/runtime.h>
#import "CommonUIConsts.h"
#import "UIViewController+transitionFunc.h"

@implementation UIViewController (commonUI)
@end



@implementation UIViewController (navigator)

+ (void)load{
    
    //设置标题
    Method originalMethod = class_getInstanceMethod(self, @selector(setTitle:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(setCommonUITitle:));
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    //navigator layout
    Method original_layout_Method = class_getInstanceMethod(self, @selector(viewWillLayoutSubviews));
    Method swizzled_layout_Method = class_getInstanceMethod(self, @selector(customViewWillLayout));
    
    method_exchangeImplementations(original_layout_Method, swizzled_layout_Method);
    
    //navigator layout
    
}

- (void)setCommonUITitle:(NSString *)title{
    [self setCommonUITitle:title];
    self.navigatorBar.title = title;
}

- (void)customViewWillLayout{
    [self customViewWillLayout];
    PTNavigationBar * _navigator = objc_getAssociatedObject(self, @selector(navigatorBar));
    _navigator.frame = ({CGRect frame  = _navigator.frame;
        frame.size.width = CGRectGetWidth(self.view.frame);
        frame;});
}


- (BOOL)needNavigatorBar{
    return YES;
}

- (PTNavigationBar *)navigatorBar{
    id navigator = objc_getAssociatedObject(self, _cmd);
    if (navigator == nil && self.needNavigatorBar) {
        CGFloat originY =  ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) ? 20 : 0;
        PTNavigationBar *navigationBar = [[PTNavigationBar alloc] initWithFrame:CGRectMake(0, originY, CGRectGetHeight(self.view.frame), height_top_navigationBar)];
        navigationBar.delegate = (id<PTNavigationBarDelegate>)self;
        self.navigatorBar = navigationBar;
        id navigator = objc_getAssociatedObject(self, _cmd);
        [self.view addSubview:navigationBar];
        return navigationBar;
    }
    return navigator;
}

- (void)setNavigatorBar:(PTNavigationBar *)navigatorBar{
    objc_setAssociatedObject(self, @selector(navigatorBar), navigatorBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)navigationButtonAction:(PTNavigationBarType)type{
    if (type == PTNavigationBar_left) {
        [self nav_leftAction];
    }else{
        [self nav_rightAction];
    }
}

- (void)nav_leftAction{
    [self dismissSelf];
}

- (void)nav_rightAction{
    
}

@end
