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
@property (nonatomic, strong) UILabel  *titleLabel;

- (IBAction)navigationButtonAction:(id)sender;

@end

@implementation PTNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
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

    if (0 == [self.leftButton allTargets].count) {
        [self.leftButton addTarget:self action:@selector(navigationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }

    if (0 == [self.rightButton allTargets].count) {
        [self.rightButton addTarget:self action:@selector(navigationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)navigationButtonAction:(id)sender{
    PTNavigationBarType type = (sender == self.leftButton) ? PTNavigationBar_left : PTNavigationBar_right;
    [self.delegate navigationButtonAction:type];
}

- (void)awakeFromNib{
    [self initialize];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.rightButton.frame = CGRectMake(self.frame.size.width - height_top_navigationBar, 0, height_top_navigationBar, height_top_navigationBar);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.leftButton.frame),
                                       0,
                                       CGRectGetMinX(self.rightButton.frame) - CGRectGetMaxX(self.leftButton.frame),
                                       CGRectGetHeight(self.frame));
    
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self configurationViews];
}


- (void)configurationViews{
    if (self.leftNormalImage) {
        [self.leftButton setImage:self.leftNormalImage forState:UIControlStateNormal];
    }
    if (self.leftSelectImage) {
        [self.leftButton setImage:self.leftSelectImage forState:UIControlStateNormal];
    }
    if (self.rightNormalImage) {
        [self.rightButton setImage:self.rightNormalImage forState:UIControlStateNormal];
    }
    if (self.rightSelectImage) {
        [self.rightButton setImage:self.rightSelectImage forState:UIControlStateNormal];
    }
    self.rightButtonHide = self.rightButtonHide;
}

#pragma mark - property subviews
- (UIButton *)leftButton{
    if (_leftButton == nil) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        _leftButton.frame = CGRectMake(0, 0, height_top_navigationBar, height_top_navigationBar);
        [self addSubview:self.leftButton];
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        _rightButton.frame = CGRectMake(UIScreenWidth - height_top_navigationBar, 0, height_top_navigationBar, height_top_navigationBar);
        [self addSubview:self.rightButton];
    }
    return _rightButton;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}


- (void)setRightButtonHide:(BOOL)rightButtonHide{
    _rightButtonHide = rightButtonHide;
    _rightButton.hidden = rightButtonHide;
}

- (void)setLeftButtonHide:(BOOL)leftButtonHide{
    _leftButtonHide = leftButtonHide;
    _leftButton.hidden = leftButtonHide;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}




@end
