//
//  BaseTableViewCell.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/13.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "BaseTableViewCell.h"
#import <objc/runtime.h>


#pragma mark -
@interface BaseTableViewCell ()

@property (nonatomic, strong) UIView *lineView;

@end


@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    CGFloat edgeOdd = 10;
    self.lineInset = UIEdgeInsetsMake(0, edgeOdd, 0, edgeOdd);
//    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(edgeOdd, 0, [UIScreen mainScreen].bounds.size.width - 2 * edgeOdd, 10.f)];
    self.lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.lineView];
    [self subclassInitializeViews];
    [self setUpBaseConstraits];
}

- (void)subclassInitializeViews{
    
}

- (void)setUpBaseConstraits{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(10));
        make.right.equalTo(self.mas_right).with.offset(-self.lineInset.right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@1.0f);
    }];
    [self setUpconstraints];
}

- (void)setUpconstraints{
    
}

- (void)setItem:(id)item{
    self.cellItem = item;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.lineView.hidden = self.lineHide;
}

@end

