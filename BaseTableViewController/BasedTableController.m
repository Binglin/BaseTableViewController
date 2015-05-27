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

#pragma mark -configTableView
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
    [self registerNibOrClass:self.tableView];
}


#pragma mark - register cell
- (void)registerNibOrClass:(UITableView *)tableView{
    NSArray *cellsClassArr = [self cellClassesForTable:tableView];
    
    //多种cell注册
    if (cellsClassArr && cellsClassArr.count) {
        for (Class class_cell in [self cellClassesForTable:tableView]) {
            [self registerCell:class_cell InTableView:tableView];
        }
    }
    //单种cell注册
    else{
        [self registerCell:[self cellClassForTable:tableView index:nil] InTableView:tableView];
    }
}

- (void)registerCell:(Class)cellClass InTableView:(UITableView *)tableView{
    
    NSString *cellStr = NSStringFromClass([cellClass class]);
    //xib加载cell
    if([[NSBundle mainBundle] pathForResource:cellStr ofType:@"nib"] != nil)
    {
        UINib *nib = [UINib nibWithNibName:cellStr bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellStr];
    }
    //代码写cell
    else{
        [tableView registerClass:cellClass forCellReuseIdentifier:cellStr];
    }
}

- (NSArray *)cellClassesForTable:(UITableView *)table{
    return nil;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([cellClass class])];
    [cell setItem:[self.dataSources objectAtIndex:indexPath.row]];

    return cell;
}

-(Class) cellClassForTable:(UITableView *)table index:(NSIndexPath *)indexPath{
    return [UITableViewCell class];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取cell的class
    Class cellClass = [self cellClassForTable:tableView index:indexPath];
    
    /**
     *  如果cell实现了heightForItem： 则返回该值
     *
     *  如果没有实现 则判断是否有用AutoLayout,有用则返回其的值，如果没有 则返回indexPath对应的cell的height
     *
     */
    if (![cellClass respondsToSelector:@selector(heightForItem:)]) {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        NSNumber *isUsedAutoLayout = [cellClass usedAutoLayout];
        
        /**
         *  如果isUsedAutoLayout为空，则表示并没有判断该cell类是否有使用autolayout
         */
        if (isUsedAutoLayout) {
            
            if (YES == [isUsedAutoLayout boolValue]) {
                /**
                 *  完全使用Autolayout布局时使用
                 */
                CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
                return size.height;
            }else{
                
                /* 在cell的setItem:方法中设置数据的同时设置cell的高度*/
                return CGRectGetHeight(cell.frame);
            }
        }
        /**
         *  判断该cell类是否有使用autolayout
         */
        else{
            
            //cell未使用autolayout或者条件不足时size值会为CGSizeZero
            CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            BOOL isUsedALayout = CGSizeEqualToSize(size, CGSizeZero) ? NO : YES;
            [cellClass setUsedAutoLayout:@(isUsedALayout)];
            return isUsedALayout ?  size.height : CGRectGetHeight(cell.frame);
        }
    }
    else{
        return [cellClass heightForItem:self.dataSources[indexPath.row]];
    }
}

- (id)dataAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSources[indexPath.row];
}

//获取dataSources的数据
- (void)loadMore:(BOOL)more{
    
}


@end

