//
//  UIViewController+header_footer.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/6/11.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "UIViewController+header_footer.h"


const CGFloat header_footer_height = 0.001f;


#pragma mark -  UITableViewHeaderFooterView (setItem)

@implementation UITableViewHeaderFooterView (setItem)

- (void)setHeaderItem:(id)item{
    
}

- (void)setFooterItem:(id)item{
    
}

@end



#pragma mark - UIViewController (header_footer)


@implementation UIViewController (header_footer)

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    Class footerClass = [self headerFooterClassForTable:tableView inSection:section type:TableHeaderFooter_header];
    if (footerClass == nil) {
        return nil;
    }
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(footerClass)];
    [self configurationHeader:header inTable:tableView section:section];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    Class footerClass = [self headerFooterClassForTable:tableView inSection:section type:TableHeaderFooter_footer];
    if (footerClass == nil) {
        return nil;
    }
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(footerClass)];
    [self configurationFooter:footer inTable:tableView section:section];
    return footer;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        UIView *header = [self tableView:tableView viewForHeaderInSection:section];
        if (header) { return CGRectGetHeight(header.frame); }
    }
    return header_footer_height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        UIView *footer = [self tableView:tableView viewForFooterInSection:section];
        if (footer) { return CGRectGetHeight(footer.frame); }
    }
    return header_footer_height;
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#pragma mark - headerFooter
//UITableViewHeaderFooterView无法添加xib，只能code子类化咯 :(
- (NSArray *)headerFooterForTable:(UITableView *)tableView{
    return nil;
}

- (void)registerHeaderFooter:(UITableView *)tableView{
    NSArray *header_footer_ClassArr = [self headerFooterForTable:tableView];
    //header_footer注册
    if (header_footer_ClassArr && header_footer_ClassArr.count) {
        for (Class class_headerFooter in header_footer_ClassArr) {
            [self registerHeaderFooter:class_headerFooter inTableView:tableView];
        }
    }else{
        Class headerFooter_class = [self headerFooterClassForTable:tableView inSection:-1 type:TableHeaderFooter_footer | TableHeaderFooter_header];
        if (headerFooter_class) {
            [self registerHeaderFooter:headerFooter_class inTableView:tableView];
        }
    }
}

- (void)registerHeaderFooter:(Class)headerFooterClass inTableView:(UITableView *)tableView{
    NSString *headerFooterClassStr = NSStringFromClass([headerFooterClass class]);
    [tableView registerClass:headerFooterClass forHeaderFooterViewReuseIdentifier:headerFooterClassStr];
}


- (Class)headerFooterClassForTable:(UITableView *)table inSection:(NSInteger)section type:(TableHeaderFooterType)headerOrFooter{
    if (section == -1) {
        return nil;
    }
    return [UITableViewHeaderFooterView class];
}


- (void)configurationFooter:(UIView *)footer inTable:(UITableView *)table section:(NSInteger)section{
    
}


- (void)configurationHeader:(UIView *)header inTable:(UITableView *)table section:(NSInteger)section{
    
}


#pragma mark  headerFooter end
@end
