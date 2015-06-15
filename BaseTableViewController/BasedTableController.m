//
//  BasedTableController.m
//
//  Created by Zhenglinqin on 15/3/9.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "BasedTableController.h"
#import "BaseTableViewCell.h"
#import "UIViewController+commonUI.h"
#import <objc/runtime.h>

@interface BasedTableController ()

@end

@implementation BasedTableController


- (instancetype)init{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)loadView{
    [super loadView];
    [self initialTableView];
}

- (CGRect)initialframeForTable{
    CGRect frame = [super initialframeForTable];
    if (self.navigatorBar) {
        self.navigationController.navigationBar.hidden = YES;
        

    }else{
        self.navigationController.navigationBar.hidden = NO;
        frame.origin.y = CGRectGetMaxY(self.navigatorBar.frame);
        frame.size.height = frame.size.height - frame.origin.y;
    }
    
    [self.view bringSubviewToFront:self.navigatorBar];
    return frame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    if (self.navigatorBar) {
        self.tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.navigatorBar.frame), 0, 0, 0);
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
        if (self.tableView.contentOffset.y < 1.f)
        {
            self.tableView.contentOffset = CGPointMake(0, -66);
        }
    }
    [self loadMore:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //tableView editing状态(删除按钮显示时)返回上一级 会崩溃解决 不需要删除功能可不要此代码
    //self.tableView.editing = NO;
    if (self.tableView.editing) {
        self.tableView.editing = NO;
    }
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = [self initialframeForTable];
}


@end



