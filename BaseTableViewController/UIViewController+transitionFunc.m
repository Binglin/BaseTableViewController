//
//  UIViewController+transitionFunc.m
//
//
//  Created by Zhenglinqin on 14-9-30.
//  Copyright (c) 2014年 Binglin. All rights reserved.
//

#import "UIViewController+transitionFunc.h"

@implementation UIViewController (transitionFunc)

- (void)presentVCClass:(Class)classname{
    [self presentVCClass:classname Animated:YES];
}

- (void)presentVCClass:(Class)classname Animated:(BOOL)animate{
    UIViewController *vc = [[classname alloc] init];
    [self presentViewController:vc animated:animate completion:nil];
}

- (void)presentVC:(UIViewController *)vc Animated:(BOOL)animate{
    [self presentViewController:vc animated:animate completion:nil];
}

- (void)pushVCClass:(Class)classname{
    [self pushVCClass:classname Animated:YES];
}

- (void)pushVCClass:(Class)classname Animated:(BOOL)animate{
    UIViewController *vc = [[classname alloc] init];
    [self.navigationController pushViewController:vc animated:animate];
}

- (void)pushVC:(UIViewController *)vc Animated:(BOOL)animate{
    [self.navigationController pushVC:vc Animated:animate];
}



- (void)dismissSelf{
    [self dismissSelfAnimated:YES];
}

- (void)dismissSelfAnimated:(BOOL)animate{
    if (self.navigationController && [self.navigationController popViewControllerAnimated:animate]) {
        return;
    }
    [self dismissViewControllerAnimated:animate completion:nil];
}


@end
