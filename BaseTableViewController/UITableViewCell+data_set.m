//
//  UITableViewCell+data_set.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/15.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "UITableViewCell+data_set.h"
#import <objc/runtime.h>

@implementation UITableViewCell (data_set)

/***  是否有使用autoLayout*/
+ (NSNumber *)usedAutoLayout{
    return objc_getAssociatedObject(self.class, @selector(usedAutoLayout));
}

+ (void)setUsedAutoLayout:(NSNumber *)isUsed{
    objc_setAssociatedObject(self.class, @selector(usedAutoLayout), isUsed, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



/** 设置cell数据,子类如果调用super setCellItem: 则存储cell的数据,不调用则不存储数据*/
- (void)setCellItem:(id)cellItem{
    return objc_setAssociatedObject(self, @selector(cellItem),cellItem, OBJC_ASSOCIATION_ASSIGN);
}

- (id)cellItem{
    return objc_getAssociatedObject(self, @selector(cellItem));
}


//+ (CGFloat)heightForItem:(id)object{
//    return 44.f;
//}

- (void)setItem:(id)item{
    self.cellItem = item;
    self.textLabel.text = item;
}

@end
