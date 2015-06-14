//
//  PTNavigationBar.m
//  BaseTableViewController
//
//  Created by 郑林琴 on 15/6/14.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "PTNavigationBar.h"
#import "CommonUIConsts.h"
#import "CommonUIEnum.h"


@interface PTNavigationBar ()

@property (nonatomic, strong) IBOutlet UIButton *leftButton;
@property (nonatomic, strong) IBOutlet UIButton *rightButton;

- (IBAction)navigationButtonAction:(id)sender;

@end

@implementation PTNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        //        [self initialize];
    }
    return self;
}

- (void)initialize{
    self.tag = CommonUI_navigationBar;
    
    if (self.leftButton == nil) {
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame = CGRectMake(0, 0, height_top_navigationBar, height_top_navigationBar);
        [self.leftButton setTitle:@"left" forState:UIControlStateNormal];
        [self addSubview:self.leftButton];
        [self.leftButton addTarget:self action:@selector(navigationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.rightButton == nil) {
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.frame = CGRectMake(UIScreenWidth - height_top_navigationBar, 0, height_top_navigationBar, height_top_navigationBar);
        [self.rightButton setTitle:@"right" forState:UIControlStateNormal];
        [self.rightButton addTarget:self action:@selector(navigationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightButton];
    }
}

- (void)navigationButtonAction:(id)sender{
    PTNavigationBarType type = (sender == self.leftButton) ? PTNavigationBar_left : PTNavigationBar_right;
    [self.delegate navigationButtonAction:type];
}

- (void)awakeFromNib{
    [self initialize];
}

@end
