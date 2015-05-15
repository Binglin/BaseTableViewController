//
//  TestTableViewCell.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/13.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "TestCodeTableViewCell.h"

@interface TestCodeTableViewCell ()

@property (nonatomic, strong) UIView *testSubView;

@end


@implementation TestCodeTableViewCell

/**
 *  代码添加cell
 */
- (void)subclassInitializeViews{
    [super subclassInitializeViews];
    self.testSubView = [[UIView alloc] init];
    self.testSubView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.testSubView];
}

- (void)setUpconstraints{
    [super setUpconstraints];
    [self.testSubView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.left.mas_equalTo(@(15));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

- (void)setItem:(id)item{
    item = [item stringByAppendingString:NSStringFromClass([self class])];
    [super setItem:item];
//    self.textLabel.text = item ;
}

+ (CGFloat)heightForItem:(id)item{
    return 80;
}

@end
