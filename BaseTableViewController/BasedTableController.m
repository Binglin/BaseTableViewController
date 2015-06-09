//
//  BasedTableController.m
//
//  Created by Zhenglinqin on 15/3/9.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "BasedTableController.h"
#import "BaseTableViewCell.h"
#import "UITableViewCell+data_set.h"
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
                                                  style:UITableViewStylePlain];
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = 44;
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

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
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

#pragma mark - height for cell with cache
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取cell的class
    Class cellClass = [self cellClassForTable:tableView index:indexPath];
    
    //cell固定高度 有可能多种cell
    if ([cellClass respondsToSelector:@selector(fixHeightForItem:)]) {
        tableView.needCache = NO;
        return [cellClass fixHeightForItem:self.dataSources[indexPath.row]];
    }
    
    NSNumber *cache = tableView.heightCache[[NSIndexSet indexSetWithIndex:indexPath.section]][indexPath];
    if (cache) {
        NSLog(@"get cached = %@ %@",indexPath,cache);
        return [cache floatValue];
    }
    
    CGFloat height = tableView.rowHeight;
    /*  如果cell实现了heightForItem： 则返回该值*/
    /*  如果没有实现 则判断是否有用AutoLayout,有用则返回其的值，如果没有 则返回indexPath对应的cell的height*/
    if (![cellClass respondsToSelector:@selector(heightForItem:)]) {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        NSNumber *isUsedAutoLayout = [cellClass usedAutoLayout];
        
        /***  如果isUsedAutoLayout为空，则表示并没有判断该cell类是否有使用autolayout*/
        if (isUsedAutoLayout) {
            
            if (YES == [isUsedAutoLayout boolValue]) {
                
                /***  完全使用Autolayout布局时使用*/
                CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
                height = size.height;
            }else{
                
                /* 在cell的setItem:方法中设置数据的同时设置cell的高度*/
                height = CGRectGetHeight(cell.frame);
            }
        }
        /***  判断该cell类是否有使用autolayout*/
        else{
            
            //cell未使用autolayout或者条件不足时size值会为CGSizeZero
            CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            [cell.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
            BOOL isUsedALayout = CGSizeEqualToSize(size, CGSizeZero) ? NO : YES;
            [cellClass setUsedAutoLayout:@(isUsedALayout)];
            height = isUsedALayout ?  size.height : CGRectGetHeight(cell.frame);
        }
    }
    else{
        height = [cellClass heightForItem:self.dataSources[indexPath.row]];
    }
    NSLog(@"not cache %@ = %f",indexPath,height);
    return height;
}

- (id)dataAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSources[indexPath.row];
}

//获取dataSources的数据
- (void)loadMore:(BOOL)more{
    
}


@end



@implementation UITableView (heightCache)

+ (void)load
{
    //需要修改height cache的方法
    SEL selectors[] = {
        @selector(reloadData),
        @selector(insertSections:withRowAnimation:),
        @selector(deleteSections:withRowAnimation:),
        @selector(reloadSections:withRowAnimation:),
        @selector(moveSection:toSection:),
        @selector(insertRowsAtIndexPaths:withRowAnimation:),
        @selector(deleteRowsAtIndexPaths:withRowAnimation:),
        @selector(reloadRowsAtIndexPaths:withRowAnimation:),
        @selector(moveRowAtIndexPath:toIndexPath:),
        @selector(exchange_layoutSubviews)

    };
    
//    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
//        SEL originalSelector = selectors[index];
//        SEL swizzledSelector = NSSelectorFromString([@"exchange_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
//        
//        Method originalMethod = class_getInstanceMethod(self, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
//        
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
}

- (void)exchange_layoutSubviews{
    [self.heightCache removeAllObjects];
    [self exchange_layoutSubviews];
}

- (void)exchange_reloadData{
    [self.heightCache removeAllObjects];
    [self exchange_reloadData];
    [self executeHeightCachce];
}

- (void)exchange_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self exchange_insertSections:sections withRowAnimation:animation];
    [self executeCacheForIndexSet:sections];
}

- (void)exchange_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self exchange_deleteSections:sections withRowAnimation:animation];
    [self removeCacheIndexSet:sections];
}

- (void)exchange_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self exchange_reloadSections:sections withRowAnimation:animation];
    [self removeCacheIndexSet:sections];
    [self executeCacheForIndexSet:sections];
}

- (void)exchange_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    [self exchange_moveSection:section toSection:newSection];
    NSIndexSet *sectionSet = [NSIndexSet indexSetWithIndex:section];
    NSIndexSet *sectionSet_new = [NSIndexSet indexSetWithIndex:newSection];
    NSDictionary *sectionCache = self.heightCache[sectionSet];
    NSDictionary *sectionNew   = self.heightCache[sectionSet_new];
    self.heightCache[sectionSet]     = sectionNew;
    self.heightCache[sectionSet_new] = sectionCache;
}

- (void)exchange_insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self exchange_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self executeCacheWithindexPathArray:indexPaths];
}

- (void)exchange_deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self removeindexPathCacheArr:indexPaths];
    [self exchange_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)exchange_reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self exchange_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self removeindexPathCacheArr:indexPaths];
    [self executeCacheWithindexPathArray:indexPaths];
}

- (void)exchange_moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    [self exchange_moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
    CGFloat height = [self heightForIndexPath:indexPath];
    CGFloat newHeight = [self heightForIndexPath:indexPath];
    [self setCacheHeight:height forIndexPath:newIndexPath];
    [self setCacheHeight:newHeight forIndexPath:indexPath];
}

- (void)removeCacheIndexPath:(NSIndexPath *)indexPath{
    if (indexPath) {
        NSMutableDictionary *sectionDic = self.heightCache[[NSIndexSet indexSetWithIndex:indexPath.section]];
        [sectionDic removeObjectForKey:indexPath];
    }
}

- (void)removeindexPathCacheArr:(NSArray *)indexPaths{
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * obj, NSUInteger idx, BOOL *stop) {
        [self removeCacheIndexPath:obj];
    }];
}

- (void)removeCacheIndexSet:(NSIndexSet *)indexSet{
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [self.heightCache removeObjectForKey:[NSIndexSet indexSetWithIndex:idx]];
    }];
}

- (NSArray *)indexPathShouldCache{
    NSMutableArray *indexPaths = @[].mutableCopy;
    NSInteger sectionsNum  = [self numberOfSections];
    
    for (int section = 0; section < sectionsNum; section ++)
    {
        NSIndexSet *sectionSet = [NSIndexSet indexSetWithIndex:section];
        NSInteger rowInSection = [self numberOfRowsInSection:section];

        NSMutableDictionary *sectionCache = self.heightCache[sectionSet];

        if (sectionCache == nil) {
            sectionCache = [NSMutableDictionary new];
            [self.heightCache setObject:sectionCache forKey:sectionSet];
        }
        
        for (int row = 0; row < rowInSection; row ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            if (sectionCache[indexPaths] == nil) {
                [indexPaths addObject:indexPath];
            }
        }
    }
    
    return indexPaths;
}

#pragma mark - height pre cache
- (void)executeHeightCachce{
    NSArray *indexPathsToCache = [self indexPathShouldCache];
    [self executeCacheWithindexPathArray:indexPathsToCache];
}

- (void)executeCacheWithindexPathArray:(NSArray *)indexPathsToCache{

    if (!self.needCache) {
        return;
    }
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFStringRef runloopMode = kCFRunLoopDefaultMode;
    
    NSMutableArray *toPrecached = indexPathsToCache.mutableCopy;
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopBeforeWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        if (toPrecached.count == 0) {
            CFRunLoopRemoveObserver(runloop, observer, runloopMode);
            CFRelease(observer);
            return ;
        }
        NSIndexPath *indexPath = toPrecached.firstObject;
        [toPrecached removeObject:indexPath];
        [self performSelector:@selector(precacheIndexPath:) onThread:[NSThread mainThread] withObject:indexPath waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
    });
    CFRunLoopAddObserver(runloop, observer, runloopMode);
}

- (void)precacheIndexPath:(NSIndexPath *)indexPath{
    NSIndexSet *sectionSet = [NSIndexSet indexSetWithIndex:indexPath.section];
    
    NSMutableDictionary *sectionDic = [self.heightCache objectForKey:sectionSet];

    if (sectionDic == nil){
        sectionDic = @{}.mutableCopy;
        [self.heightCache setObject:sectionDic forKey:sectionSet];
    }
    
    if (indexPath.section >= [self numberOfSections] ||
        indexPath.row >= [self numberOfRowsInSection:indexPath.section]) {
        return;
    }
    CGFloat height = [self.delegate tableView:self heightForRowAtIndexPath:indexPath];
    [sectionDic setObject:@(height) forKey:indexPath];
//    NSLog(@"precache height %f %@", height,indexPath);
}

- (void)executeCacheForIndexSet:(NSIndexSet *)set{

    [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSMutableArray *new = [NSMutableArray arrayWithCapacity:[self numberOfRowsInSection:idx]];
        for (int i = 0; i < [self numberOfRowsInSection:idx]; i ++) {
            [new addObject:[NSIndexPath indexPathForRow:i inSection:idx]];
            [self executeCacheWithindexPathArray:new];
        }
    }];
}



#pragma mark - property
- (NSMutableDictionary *)heightCache{
    id cache = objc_getAssociatedObject(self, _cmd);
    if (!cache) {
        cache = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN);
    }
    return cache;
}

- (void)setHeightCache:(NSMutableDictionary *)heightCache{
    objc_setAssociatedObject(self, @selector(heightCache), heightCache, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)needCache{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setNeedCache:(BOOL)needCache{
    objc_setAssociatedObject(self, @selector(needCache), @(needCache), OBJC_ASSOCIATION_COPY);
}

- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath{
    NSNumber *cache = [[self.heightCache objectForKey:[NSIndexSet indexSetWithIndex:indexPath.section] ] objectForKey:indexPath];
    if (cache) {
        return [cache floatValue];
    }
    [self precacheIndexPath:indexPath];
    return [self heightForIndexPath:indexPath];
}

- (void)setCacheHeight:(CGFloat)height forIndexPath:(NSIndexPath *)indexPath{
    NSIndexSet *sectionSet = [NSIndexSet indexSetWithIndex:indexPath.section];
    NSMutableDictionary *sectionDic = [self.heightCache objectForKey:sectionSet];
    
     if (sectionDic == nil){
        sectionDic = @{}.mutableCopy;
        [self.heightCache setObject:sectionDic forKey:sectionSet];
    }
    
    if (indexPath.section >= [self numberOfSections] ||
        indexPath.row >= [self numberOfRowsInSection:indexPath.section]) {
        return;
    }
    [sectionDic setObject:@(height) forKey:indexPath];
}


@end