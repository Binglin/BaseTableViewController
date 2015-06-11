//
//  UITableView+height_cache.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/6/11.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "UITableView+height_cache.h"
#import <objc/runtime.h>

@implementation UITableView (height_cache)

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
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"exchange_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
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
