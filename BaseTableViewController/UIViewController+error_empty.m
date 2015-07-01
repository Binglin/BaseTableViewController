//
//  UIViewController+error_empty.m
//
//
//  Created by Zhenglinqin on 14-9-5.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "UIViewController+error_empty.h"
#import "UIView+Position.h"

CGFloat edgeOddWidth = 10.f;

@implementation ErrorEmptyEntity

+ (ErrorEmptyEntity *)defaultEmptyEntity{
    ErrorEmptyEntity *empty = [ErrorEmptyEntity new];
    empty.title    = @"还没有内容哦";
    empty.subTitle = @"\n\n";
    empty.image    = @"nt_pic_smile";
    empty.viewType = SpecialViewType_Empty;
//    ShoppingButton *shopint = [ShoppingButton shoppintButton];
//    empty.button = shopint;
    return empty;
}

+ (ErrorEmptyEntity *)defaultErrorEntity{
    ErrorEmptyEntity *error = [ErrorEmptyEntity new];
    error.title    = @"网络不给力";
    error.subTitle = @"请连上网络后刷新重试";
    error.image    = @"network_error";
    error.viewType = SpecialViewType_Error;
    return error;
}

@end


@implementation UIViewController (error_empty)

- (ErrorEmptyEntity *)emptyEntity{
    ErrorEmptyEntity *empty = [ErrorEmptyEntity defaultEmptyEntity];
    if (empty.button) {
        [empty.button removeTarget:self action:@selector(emptyOrErrorAction:) forControlEvents:UIControlEventTouchUpInside];
        [empty.button addTarget:self action:@selector(emptyOrErrorAction:) forControlEvents:UIControlEventTouchUpInside];
        empty.button.tag = SpecialViewType_Empty;
    }
    return empty;
}

- (ErrorEmptyEntity *)errorEntity{
    ErrorEmptyEntity *error = [ErrorEmptyEntity defaultErrorEntity];
    if (error.button) {
        [error.button removeTarget:self action:@selector(emptyOrErrorAction:) forControlEvents:UIControlEventTouchUpInside];
        [error.button addTarget:self action:@selector(emptyOrErrorAction:) forControlEvents:UIControlEventTouchUpInside];
        error.button.tag = SpecialViewType_Error;
    }
    return error;
}

- (EmptyErrorView *)viewWithType:(SpecialViewType)viewType{
    EmptyErrorView *error_empty = (EmptyErrorView *)[self.view viewWithTag:viewType];
    return error_empty;
}

/**
 *  显示隐藏loaidng
 */
- (void)showLoading:(BOOL)show{
#warning TODO 项目 loading
    if (show) {
        /*
        [self showError:NO];
        [self showEmpty:NO];
         */
    }
}

- (void)showHUDLoading:(BOOL)show title:(NSString *)text{
    if (show) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.labelText = text;
//    }else{
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}



/**
 *  显示隐藏空界面
 */
- (void)showEmpty:(BOOL)show
{
    if (show) {
        [self showLoading:NO];
        [self showError:NO];
        ErrorEmptyEntity *entity = [self emptyEntity];

        EmptyErrorView *empty_error = [[EmptyErrorView alloc] initWithFrame:self.view.bounds emptyerror:entity];
        [self.view addSubview:empty_error];
        empty_error.top = self.view.top;
        
    }else{
        EmptyErrorView *empty_error = [self viewWithType:SpecialViewType_Empty];
        [empty_error removeFromSuperview];
    }
}

/**
 *  显示隐藏错误界面
 */
- (void)showError:(BOOL)show
{
    /*
    if (show) {
        ErrorEmptyEntity *entity = [self errorEntity];

        [self showLoading:NO];
        [self showEmpty:NO];
        
        EmptyErrorView *empty_error = [[EmptyErrorView alloc] initWithFrame:self.viewContainer.bounds emptyerror:entity];
        [self.view addSubview:empty_error];
        empty_error.top = self.viewContainer.top;
    }else{
        EmptyErrorView *empty_error = [self viewWithType:SpecialViewType_Error];
        [empty_error removeFromSuperview];
    }
    */
}

//- (void)showError:(BOOL)show WithModel:(ErrorEntity *)error{
//#warning TODO 结合本项目接口错误处理
//    [self showError:show];
//}


- (void)topToastText:(NSString *)text inView:(UIView *)view{
    
}

/*
 *  版本升级界面
 */
- (void)showUpdateVersion{
    
}

/**
 *  空页面或者网络错误页面按钮事件 ～ 子类实现
 */
- (void)emptyOrErrorAction:(UIButton *)sender{
    
}

@end




/*空页面及网络错误页面*/
@interface EmptyErrorView (){
    UIButton *_button;
}

@property (nonatomic, strong) UILabel *tintLabel;

@end

@implementation EmptyErrorView

- (instancetype)initWithFrame:(CGRect)frame emptyerror:(ErrorEmptyEntity *)error_empty_entity{
    if (self = [self initWithFrame:frame]) {
        self.tag = error_empty_entity.viewType;
        self.tintLabel.text = error_empty_entity.title;
        self.tintLabel.textAlignment = NSTextAlignmentCenter;
        if (error_empty_entity.button) {
            _button = error_empty_entity.button;
            [self addSubview:_button];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat labelHeight = 200;
        self.tintLabel = [[UILabel alloc] initWithFrame:CGRectMake(edgeOddWidth, self.height/2.0f - labelHeight/2.f, self.width - 2 * edgeOddWidth, labelHeight)];
        self.tintLabel.numberOfLines = 0;
        [self addSubview:self.tintLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tintLabel.size = [self.tintLabel sizeThatFits:CGSizeMake( self.width, 1000.f)];
    self.tintLabel.centerX = self.centerX;
    _button.centerX = self.centerX;
    _button.centerY = self.bottom/2.f - self.top/2.f;
    self.tintLabel.bottom = _button.top -  20.f;
}

@end
