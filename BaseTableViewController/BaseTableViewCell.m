//
//  BaseTableViewCell.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/13.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell ()

@property (nonatomic, strong) UIView *lineView;

@end


@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self config];
    }
    return self;
}

- (void)config{
    CGFloat edgeOdd = 10;
    self.lineInset = UIEdgeInsetsMake(0, edgeOdd, 0, edgeOdd);
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(edgeOdd, 0, [UIScreen mainScreen].bounds.size.width - 2 * edgeOdd, 1.f)];
    self.lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.lineView];
    [self subViewConfig];
}

- (void)subViewConfig{
    
}

- (void)setItem:(id)item{
    self.cellItem = item;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    if (self.lineHide == NO) {
//        self.lineView.left = self.lineInset.left;
//        self.lineView.width = self.width - self.lineInset.left - self.lineInset.right;
//        self.lineView.bottom = self.height;
//    }else{
//        self.lineView.hidden = YES;
//    }
//}

@end
