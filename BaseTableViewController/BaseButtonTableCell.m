//
//  BaseButtonTableCell.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/15.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "BaseButtonTableCell.h"

@implementation BaseButtonTableCell


- (void)buttonActioned:(UIButton *)sender{
    if (self.viewController) {
        if ([self.viewController respondsToSelector:@selector(buttonActionCellType:data:)]) {
            [self.viewController buttonActionCellType:[self class] data:self.cellItem];
        }else if ([self.viewController respondsToSelector:@selector(buttonActionBtnType:data:)]){
            if (sender.tag) {
                [self.viewController buttonActionBtnType:sender.tag data:self.cellItem];
            }else{
                NSAssert(sender.tag == 0, @"BaseButtonTableCell 没有设置button的tag");
            }
        }
    }
    NSLog(@"%@",sender.titleLabel.text);
}


@end







#pragma mark -
@interface OneButtonTableViewCell ()

@property (strong, nonatomic)  UIButton *actionButton;

@end


/*带一个button的基础类*/
@implementation OneButtonTableViewCell

- (void)subclassInitializeViews{
    self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.actionButton];
    [self.actionButton addTarget:self action:@selector(buttonActioned:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionButton setTitle:@"点击查看" forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.actionButton.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    self.actionButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.actionButton.layer.borderWidth = 2.0f;
    self.actionButton.layer.cornerRadius = 6.0f;
    [self.contentView addSubview:self.actionButton];
}

- (void)setUpconstraints{
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-10.f);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

@end
