//
//  BasedTableController.m
//
//  Created by Zhenglinqin on 15/3/9.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "BasedTableController.h"
#import "BaseTableViewCell.h"
#import "BasedTableController+cell.h"
#import "UIViewController+header_footer.h"
#import <objc/runtime.h>

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

#pragma mark -configTableView
- (void)configTableView{
    self.tableView = [[UITableView alloc] initWithFrame:[self initialframeForTable]
                                                  style:[self customStyleForTable:self.tableView]];
    self.tableView.delegate     = (id<UITableViewDelegate>)self;
    self.tableView.dataSource   = (id<UITableViewDataSource>)self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = 44;
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 1.f)];
    self.tableView.tableFooterView = footer;

    [self register_cell:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setEstimatedRowHeight:)]) {
        self.tableView.estimatedRowHeight = 44.f;
    }
    
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
#ifdef UIViewController_Header_footer_category
    [self registerHeaderFooter:self.tableView];
#endif
}

- (UITableViewStyle)customStyleForTable:(UITableView *)tableView{
    return UITableViewStylePlain;
}


#pragma mark - private
//计算tableView的frame
- (CGRect)initialframeForTable{
    CGRect frame = self.view.bounds;
//    UINavigationController *nav = self.navigationController;
//    UINavigationBar *bar = self.navigationController.navigationBar;
//    BOOL hidden = bar.hidden;
//    if (nav && bar && (hidden == NO)) {
//        frame.size.height = CGRectGetHeight(self.view.frame)-CGRectGetMaxY(bar.frame);
//    }
    return frame;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = [self initialframeForTable];
}



- (id)dataAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSources[indexPath.row];
}

- (void)appendDataWith:(NSArray *)datas withMore:(BOOL)more{
    if (!more) {
        [self.dataSources removeAllObjects];
    }
    [self.dataSources addObjectsFromArray:datas];
}

//获取dataSources的数据
- (void)loadMore:(BOOL)more{
    
}


@end



