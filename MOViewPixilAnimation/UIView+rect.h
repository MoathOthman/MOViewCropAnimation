//
//  UIView+rect.h
//  PullToRefresh
//
//  Created by moath othman on 9/3/13.
//
//

#import <UIKit/UIKit.h>

@interface UIView (rect)
-(void)setXPoint:(CGFloat)xPoint;
-(void)setYPoint:(CGFloat)yPoint;

-(void)setWidth:(CGFloat)width;
-(void)setHeight:(CGFloat)height;
-(void)addSubViews:(NSArray*)array;

-(CGFloat)height;
-(CGFloat)width;
-(CGFloat)XPoint;
-(CGFloat)YPoint;

@end
