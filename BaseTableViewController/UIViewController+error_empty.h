//
//  UIViewController+error_empty.h
//
//
//  Created by Zhenglinqin on 14-9-5.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasedTableController.h"
/**
 特殊界面type
 */
typedef enum SpecialViewType{
    SpecialViewType_loading = 10330,
    SpecialViewType_Empty ,
    SpecialViewType_Empty_Button,
    SpecialViewType_Error,
    
}SpecialViewType;



#define Empty_string(key,comment)       NSLocalizedStringFromTable(key, @"EmptyErrorString", comment)
#define Error_string(key,comment)       NSLocalizedStringFromTable(key, @"EmptyErrorString", comment)

/**
 *  空界面 错误界面model
 */
@interface ErrorEmptyEntity : NSObject

@property (nonatomic, strong) NSString          *title;
@property (nonatomic, strong) NSString          *subTitle;
@property (nonatomic, strong) NSString          *image;
@property (nonatomic, strong) UIButton          *button;
@property (nonatomic, assign) SpecialViewType   viewType;

+ (ErrorEmptyEntity *)defaultEmptyEntity;
+ (ErrorEmptyEntity *)defaultErrorEntity;

@end



#pragma mark -
/**
 *  特殊页面如空 错误界面处理
 *  special view error / empty / loading
 */
@interface UIViewController (error_empty)

- (ErrorEmptyEntity *) emptyEntity;
- (ErrorEmptyEntity *) errorEntity;

/**
 *  show or hide loading
 */
- (void)showLoading: (BOOL)show;
- (void)showHUDLoading:(BOOL)show title:(NSString *)text;

/**
 *  显示隐藏错误界面 
 *  show or hide error view
 */
- (void)showError  : (BOOL)show;
/*- (void)showError  : (BOOL)show WithModel:(ErrorEntity * )error;*/


/**
 *  显示隐藏空界面 
 *  show or hide  empty view
 */
- (void)showEmpty  : (BOOL)show;



- (void)topToastText:(NSString *)text inView:(UIView *)view;

/*
 *  版本升级界面
 */
- (void)showUpdateVersion;

/**
 *  空页面或者网络错误页面按钮事件 ～ 子类实现
 */
- (void)emptyOrErrorAction:(UIButton *)sender;

@end




@interface EmptyErrorView : UIView

- (instancetype)initWithFrame:(CGRect)frame emptyerror:(ErrorEmptyEntity *)error_empty_entity;

@end
