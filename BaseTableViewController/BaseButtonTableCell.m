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


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.actionButton];
        [self.actionButton addTarget:self action:@selector(buttonActioned:) forControlEvents:UIControlEventTouchUpInside];
        [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.actionButton sizeToFit];
    self.actionButton.right = self.width - 10.f;
    self.actionButton.center = CGPointMake(self.actionButton.center.x, self.height/2.f);
}
@end
