//
//  UIView+Position.h
//  
//
//  Created by Zhenglinqin on 14/11/19.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);

CGRect CGRectSetMinX(CGRect rect, CGFloat x);
CGRect CGRectSetMidX(CGRect rect, CGFloat x);
CGRect CGRectSetMaxX(CGRect rect, CGFloat x);

CGRect CGRectSetMinY(CGRect rect, CGFloat y);
CGRect CGRectSetMidY(CGRect rect, CGFloat y);
CGRect CGRectSetMaxY(CGRect rect, CGFloat y);


CGRect CGRectSetWidth (CGRect rect, CGFloat width);
CGRect CGRectSetHeight(CGRect rect, CGFloat height);

CGRect CGRectMultiple(CGRect rect, CGFloat ratio);
CGRect CGRectDivideBy(CGRect rect, CGFloat divideRatio);

CGPoint CGRectGetOrigin(CGRect rect);
CGSize  CGRectGetSize  (CGRect size);





@interface UIView (Position)

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;


@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGPoint origin;
- (void) setOrigin:(CGPoint)origin Width:(CGFloat)width;

@property (nonatomic, assign) CGSize  size;

@property (nonatomic, assign) CGPoint rightTop;
@property (nonatomic, assign) CGPoint bottomLeft;
@property (nonatomic, assign) CGPoint bottomright;

@property (nonatomic, assign) CGPoint leftWidth;
@property (nonatomic, assign) CGPoint topWidth;
@property (nonatomic, assign) CGPoint rightWidth;
@property (nonatomic, assign) CGPoint bottomWidth;

@property (nonatomic, assign) CGPoint bottomCenterX;
@property (nonatomic, assign) CGPoint rightCenterY;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;
@end





