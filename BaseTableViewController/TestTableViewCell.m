//
//  TestTableViewCell.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/13.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "TestTableViewCell.h"

@interface TestTableViewCell ()

@property (nonatomic, strong) UIView *testSubView;

@end


@implementation TestTableViewCell

/**
 *  代码添加cell
 */
- (void)subclassInitializeViews{
    
}

- (void)setItem:(id)item{
    [super setItem:item];
    self.textLabel.text = item;
}

+ (CGFloat)heightForItem:(id)item{
    return 80;
}

@end
