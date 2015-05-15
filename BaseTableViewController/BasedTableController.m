//
//  BasedTableController.m
//
//  Created by Zhenglinqin on 15/3/9.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "BasedTableController.h"
#import "BaseTableViewCell.h"
#import "UITableViewCell+data_set.h"

@interface BasedTableController ()

@property (nonatomic, strong)  UITableView *tableView;

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
    self.dataSources = [NSMutableArray array];
    if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configTableView];
    [self loadMore:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //tableView editing状态(删除按钮显示时)返回上一级 会崩溃解决 不需要删除功能可不要此代码
    //self.tableView.editing = NO;
}


- (void)configTableView{
    self.tableView = [[UITableView alloc] initWithFrame:[self initialframeForTable]
                                                  style:UITableViewStylePlain];
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 1.f)];
    self.tableView.tableFooterView = footer;
}


#pragma mark - private
//计算tableView的frame
- (CGRect)initialframeForTable{
    CGRect frame = self.view.frame;
    UINavigationController *nav = self.navigationController;
    UINavigationBar *bar = self.navigationController.navigationBar;
    BOOL hidden = bar.hidden;
    if (nav && bar && (hidden == NO)) {
        frame.size.height = CGRectGetHeight(self.view.frame)-CGRectGetMaxY(bar.frame);
    }
    return frame;
}

#pragma mark -  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}

/**
 *  子类继承自BaseTableViewCell 并重写setItem:方法设置数据显示
 *  可自动显示xib定制的cell，也能显示code生成的cell
 *  xib生成的cell 请使用autolayout
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Class  cellClass = [self cellClassForTable:tableView index:indexPath];
    UITableViewCell *cell = [cellClass dequeueResuableCellWithTableView:tableView];
    [cell setItem:[self.dataSources objectAtIndex:indexPath.row]];

    return cell;
}

-(Class) cellClassForTable:(UITableView *)table index:(NSIndexPath *)indexPath{
    return [UITableViewCell class];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Class cellClass = [self cellClassForTable:tableView index:indexPath];
    return [cellClass heightForItem:self.dataSources[indexPath.row]];
}

- (id)dataAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSources[indexPath.row];
}

//获取dataSources的数据
- (void)loadMore:(BOOL)more{
    
}


@end

