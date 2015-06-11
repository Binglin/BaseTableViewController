//
//  BasedTableController+cell.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/6/11.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "BasedTableController+cell.h"
#import "UITableView+height_cache.h"
#import "UITableViewCell+data_set.h"

@interface UINib (nib)
/**
 *  如果nib存在则返回该nib 否则 返回空
 */
+ (UINib *)loadNibName:(NSString *)name bundle:(NSBundle *)bundleOrNil;

@end

@implementation UINib (nib)

+ (UINib *)loadNibName:(NSString *)name bundle:(NSBundle *)bundleOrNil{
    NSString *nibPath = [[NSBundle mainBundle] pathForResource:name ofType:@"nib"];
    if (nibPath) {
        return [UINib nibWithNibName:name bundle:bundleOrNil];
    }
    return nil;
}

@end


@implementation BasedTableController (cell)



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
    [cell setItem:[self dataAtIndexPath:indexPath]];
    
    return cell;
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
        height = [cellClass heightForItem:[self dataAtIndexPath:indexPath]];
    }
    NSLog(@"not cache %@ = %f",indexPath,height);
    return height;
}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark - cell class
- (Class)cellClassForTable:(UITableView *)table index:(NSIndexPath *)indexPath{
    return [UITableViewCell class];
}



#pragma mark - cell register
- (void)register_cell:(UITableView *)tableView{
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
    UINib *nib = [UINib loadNibName:cellStr bundle:nil];
    if(nib){ [tableView registerNib:nib forCellReuseIdentifier:cellStr];}
    //代码写cell
    else{ [tableView registerClass:cellClass forCellReuseIdentifier:cellStr]; }
}

- (NSArray *)cellClassesForTable:(UITableView *)table{
    return nil;
}

#pragma mark  register cell end

@end
