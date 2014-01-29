//
//  UIView+rect.m
//  PullToRefresh
//
//  Created by moath othman on 9/3/13.
//
//

#import "UIView+rect.h"

@implementation UIView (rect)

-(void)setXPoint:(CGFloat)xPoint{
    CGRect tFrame=self.frame;
    tFrame.origin.x=xPoint;
    [self setFrame:tFrame];
}
-(void)setYPoint:(CGFloat)yPoint{
    CGRect tFrame=self.frame;
    tFrame.origin.y=yPoint;
    [self setFrame:tFrame];
}

-(void)setWidth:(CGFloat)width{
    CGRect tFrame=self.frame;
    tFrame.size.width=width;
    [self setFrame:tFrame];
}
-(void)setHeight:(CGFloat)height{
    CGRect tFrame=self.frame;
    tFrame.size.height=height;
    [self setFrame:tFrame];
}

-(void)addSubViews:(NSArray*)array;
{
    for (UIView *view in array) {
        [self addSubview:view];
    }
}

-(CGFloat)height {
    return self.frame.size.height;
}

-(CGFloat)width;{
     return self.frame.size.width;
}
-(CGFloat)XPoint;{
     return self.frame.origin.x;
}
-(CGFloat)YPoint;{
    return self.frame.origin.y;
}
@end
