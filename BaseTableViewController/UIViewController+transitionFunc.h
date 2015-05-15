//
//  UIViewController+transitionFunc.h
//  
//
//  Created by Zhenglinqin on 14-9-30.
//  Copyright (c) 2014年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (transitionFunc)

/**
 *  @param animate   无此参数默认为YES
 */
- (void)presentVCClass:(Class)classname;
- (void)presentVCClass:(Class)classname Animated:(BOOL)animate;
- (void)presentVC:(UIViewController *)vc Animated:(BOOL)animate;

- (void)pushVCClass:(Class)classname;
- (void)pushVCClass:(Class)classname Animated:(BOOL)animate;
- (void)pushVC:(UIViewController *)vc Animated:(BOOL)animate;

- (void)dismissSelf;
- (void)dismissSelfAnimated:(BOOL)animate;

@end
