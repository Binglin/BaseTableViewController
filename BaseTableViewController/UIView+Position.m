//
//  UIView+Position.m
//
//
//  Created by Zhenglinqin on 14/11/19.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "UIView+Position.h"

@implementation UIView (Position)

#pragma mark - x
CGPoint CGRectGetCenter(CGRect rect){
    return  CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGRect CGRectSetMinX(CGRect rect, CGFloat x){
    if (DEBUG) {
        rect.origin.x = x;
        return rect;
    }
    CGRect newRect = rect;
    newRect.origin.x = x;
    return newRect;
}

CGRect CGRectSetMidX(CGRect rect, CGFloat x){
    if (DEBUG) {
        rect.origin.x = x - CGRectGetWidth(rect)/2.0f;
        return rect;
    }
    CGRect newRect = rect;
    newRect.origin.x = x - CGRectGetWidth(newRect)/2.f;
    return newRect;
}

CGRect CGRectSetMaxX(CGRect rect, CGFloat x){
    if (DEBUG) {
        rect.origin.x = x - CGRectGetWidth(rect);
        return rect;
    }
    CGRect newRect = rect;
    newRect.origin.x = x - CGRectGetWidth(newRect);
    return newRect;
}

#pragma mark - y
CGRect CGRectSetMinY(CGRect rect, CGFloat y){
    if (DEBUG) {
        rect.origin.y = y;
        return rect;
    }
    CGRect newRect = rect;
    newRect.origin.y = y;
    return newRect;
}

CGRect CGRectSetMidY(CGRect rect, CGFloat y){
    if (DEBUG) {
        rect.origin.y = y - CGRectGetHeight(rect)/2.f                                                                                                                                                                                  ;
        return rect;
    }
    CGRect newRect = rect;
    newRect.origin.y = y - CGRectGetHeight(newRect)/2.f;
    return newRect;
}

CGRect CGRectSetMaxY(CGRect rect, CGFloat y){
    if (DEBUG) {
        rect.origin.y = y - CGRectGetHeight(rect);
        return rect;
    }
    CGRect newRect = rect;
    newRect.origin.y = y - CGRectGetHeight(newRect);
    return newRect;
}

#pragma mark - width
CGRect CGRectSetWidth (CGRect rect, CGFloat width){
    if (DEBUG) {
        rect.size.width = width;
        return rect;
    }
    CGRect newRect = rect;
    newRect.size.width = width;
    return newRect;
}


CGRect CGRectSetHeight(CGRect rect, CGFloat height){
    if (DEBUG) {
        rect.size.height = height;
        return rect;
    }
    CGRect newRect = rect;
    newRect.size.height = height;
    return newRect;
}

CGRect CGRectMultiple(CGRect rect, CGFloat ratio){
    CGRect newRect = rect;
    newRect.size.width  *= ratio;
    newRect.size.height *= ratio;
    return newRect;
}

CGRect CGRectDivideBy(CGRect rect, CGFloat divideRatio){
    CGRect newRect = rect;
    newRect.size.width  = divideRatio;
    newRect.size.height = divideRatio;
    return newRect;
}

CGPoint CGRectGetOrigin(CGRect rect){
    return rect.origin;
}

CGSize  CGRectGetSize  (CGRect rect){
    return rect.size;
}

#pragma mark - top
- (CGFloat)top{
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)top{
    CGRect frame = self.frame ;
    self.frame = CGRectSetMinY(frame, top);
}

#pragma mark - bottom
- (CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame ;
    self.frame = CGRectSetMaxY(frame, bottom);
}

#pragma mark - left
- (CGFloat)left{
    return CGRectGetMinX(self.frame);
}

- (void)setLeft:(CGFloat)left{
    CGRect frame = self.frame ;
    self.frame = CGRectSetMinX(frame, left);
}

#pragma mark - right

- (CGFloat)right{
    return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)right{
    CGRect frame = self.frame ;
    self.frame = CGRectSetMaxX(frame, right);
}

#pragma mark - width
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame ;
    self.frame = CGRectSetWidth(frame, width);
}

- (CGFloat)width{
    return CGRectGetWidth(self.frame);
}

#pragma mark - height
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame ;
    self.frame = CGRectSetHeight(frame, height);;
}

- (CGFloat)height{
    return CGRectGetHeight(self.frame);
}

#pragma mark - centerX
- (void)setCenterX:(CGFloat)centerX{
    CGRect frame = self.frame ;
    self.frame = CGRectSetMidX(frame, centerX);
}

- (CGFloat)centerX{
    return CGRectGetMidX(self.frame);
}

#pragma mark - centerY
- (void)setCenterY:(CGFloat)centerY{
    CGRect frame = self.frame ;
    self.frame = CGRectSetMidY(frame, centerY);
}

- (CGFloat)centerY{
    return CGRectGetMidY(self.frame);
}
#pragma mark - origin
- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin= origin;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin Width:(CGFloat)width{
    CGRect frame = self.frame;
    frame.origin= origin;
    frame.size.width = width;
    self.frame = frame;
}



#pragma mark - size
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

#pragma mark - rightTop

- (CGPoint)rightTop{
    CGRect frame = self.frame;
    return CGPointMake(CGRectGetMaxX(frame), CGRectGetMinY(frame));
}

- (void)setRightTop:(CGPoint)rightTop{
    CGRect frame = self.frame;
    frame = CGRectSetMaxX(frame, rightTop.x);
    frame = CGRectSetMinY(frame, rightTop.y);
    self.frame = frame;
}
#pragma mark - bottomLeft

- (CGPoint) bottomLeft
{
    return CGPointMake(self.left, CGRectGetMaxY(self.frame));
}

- (void)setBottomLeft:(CGPoint)bottomLeft{
    CGRect frame = self.frame;
    frame = CGRectSetMaxY(frame, bottomLeft.x);
    frame = CGRectSetMinX(frame, bottomLeft.y);
    self.frame = frame;
}

#pragma mark - bottomright
- (CGPoint)bottomright{
    CGRect rect = self.frame;
    return CGPointMake(CGRectGetMaxY(rect), CGRectGetMaxX(rect));
}

- (void)setBottomright:(CGPoint)bottomright{
    CGRect rect = self.frame;
    rect = CGRectSetMaxX(rect, bottomright.y);
    rect = CGRectSetMaxY(rect, bottomright.x);
    self.frame = rect;
}

#pragma mark - leftWidth
- (CGPoint)leftWidth{
    CGRect rect = self.frame;
    return CGPointMake(CGRectGetMidX(rect), CGRectGetWidth(rect));
}

- (void)setLeftWidth:(CGPoint)leftWidth{
    CGRect rect = self.frame;
    rect = CGRectSetWidth(rect, leftWidth.y);
    rect = CGRectSetMinX(rect, leftWidth.x);
    self.frame = rect;
}

#pragma mark - topWidth
- (CGPoint)topWidth{
    CGRect rect = self.frame;
    return CGPointMake(CGRectGetMinX(rect), CGRectGetWidth(rect));
}

- (void)setTopWidth:(CGPoint)topWidth{
    CGRect rect = self.frame;
    rect = CGRectSetMinY(rect, topWidth.x);
    rect = CGRectSetWidth(rect, topWidth.y);
    self.frame = rect;
}

#pragma mark - rightWidth
- (void)setRightWidth:(CGPoint)rightWidth{
    CGRect rect = self.frame;
    rect = CGRectSetWidth(rect, rightWidth.y);
    rect = CGRectSetMaxX(rect, rightWidth.x);
    self.frame = rect;
}

- (CGPoint)rightWidth{
    CGRect rect = self.frame;
    return CGPointMake(CGRectGetMaxX(rect), CGRectGetWidth(rect));
}
#pragma mark - bottomWidth
- (void)setBottomWidth:(CGPoint)bottomWidth{
    CGRect rect = self.frame;
    rect = CGRectSetMaxY(rect, bottomWidth.x);
    rect = CGRectSetWidth(rect, bottomWidth.y);
    self.frame = rect;
}
- (CGPoint)bottomWidth{
    CGRect rect = self.frame;
    return CGPointMake(CGRectGetMaxY(rect), CGRectGetWidth(rect));
}

#pragma mark - bottomCenterX

- (void)setBottomCenterX:(CGPoint)bottomCenterX{
    CGRect rect = self.frame;
    rect = CGRectSetMaxY(rect, bottomCenterX.x);
    rect = CGRectSetMidX(rect, bottomCenterX.y);
    self.frame = rect;
}
- (CGPoint)bottomCenterX{
    CGRect rect = self.frame;
    return CGPointMake(CGRectGetMaxY(rect), CGRectGetMidX(rect));
}

#pragma mark - rightCenterX
- (void)setRightCenterY:(CGPoint)rightCenterY{
    CGRect rect = self.frame;
    rect = CGRectSetMaxX(rect, rightCenterY.x);
    rect = CGRectSetMidY(rect, rightCenterY.y);
    self.frame = rect;
}

- (CGPoint)rightCenterY{
    return CGPointMake(self.right, self.centerY);
}



// Move via offset
- (void) moveBy: (CGPoint) delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;	
}
@end
