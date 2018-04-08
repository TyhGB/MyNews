//
//  UIView+YHExtension.m
//  test
//
//  Created by TyhOS on 2017/12/24.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "UIView+YHExtension.h"

@implementation UIView (YHExtension)

@dynamic maxX,maxY;

-(void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}
-(CGFloat)x
{
    return self.frame.origin.x;
}
-(void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}
-(CGFloat)y
{
    return self.frame.origin.y;
}
-(void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
-(CGFloat)width
{
    return self.frame.size.width;
}
-(void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
-(CGFloat)height
{
    return  self.frame.size.height;
}

-(CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}
-(CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}
@end
