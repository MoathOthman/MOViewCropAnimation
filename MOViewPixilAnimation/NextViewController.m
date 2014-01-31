//
//  NextViewController.m
//  MOViewPixilAnimation
//
//  Created by moath othman on 1/29/14.
//  Copyright (c) 2014 moath othman. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()
{
    NSMutableArray *chosenIdx;
    NSMutableArray *chosenImages;
    NSMutableArray *orImages;
}
@end

@implementation NextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    chosenIdx=[NSMutableArray new];
    chosenImages=[NSMutableArray new];
    orImages =[NSMutableArray new];
	// Do any additional setup after loading the view.
}


- (IBAction)cropAndShuffle:(id)sender {
    [ArrayOfImages removeAllObjects];
    [orImages removeAllObjects];
    [self okLetsHaveFunForXs:YES];
}

-(BOOL)isitChosenIndex:(NSNumber*)idx{
    
    for (NSNumber*n in chosenIdx) {
        if (n.intValue==idx.intValue) {
       //     NSLog(@"number %@ is chosen before",idx);
            return YES;
        }
    }
   // NSLog(@"number %@ is not  chosen before",idx);

    return NO;
}
- (void)animateimage:(MOImageView *)obj {
    [UIView animateWithDuration:1.25  animations:^{
       //[obj setYPoint:obj.YPoint+100];
       // NSLog(@"array count %i",ArrayOfImages.count);
        int index=arc4random_uniform(ArrayOfImages.count);
        NSNumber *idx=[NSNumber numberWithInt:index];
        while ([self isitChosenIndex:idx] || [ArrayOfImages indexOfObject:obj]==idx.intValue) {
              index=arc4random_uniform(ArrayOfImages.count);
              idx=[NSNumber numberWithInt:index];
        }
        [chosenIdx addObject:idx];
        
   
        MOImageView *chpsenimg=(MOImageView*)[ArrayOfImages objectAtIndex:idx.intValue];
       // obj.frame=[chpsenimg frame];
        [chosenImages addObject:chpsenimg];
        float newX =(obj.orX -chpsenimg.orX)-0;
        float newy =obj.orY-chpsenimg.orY;
        
       
        obj.XPoint =obj.XPoint-newX;
        obj.YPoint=obj.YPoint-newy;
        NSLog(@"new index is %i,cfr %f\n ,,%f,%f ",index, newX,obj.orX ,chpsenimg.orX);

        
       // [ArrayOfImages replaceObjectAtIndex:[ArrayOfImages indexOfObject:obj] withObject: chpsenimg ];
        //chpsenimg.YPoint+=200;
        
        
        //             NSLog(@"new index is %i,cfr %@\n ,,new frame %@",index,NSStringFromCGRect( obj.frame),NSStringFromCGRect( chpsenimg.frame));

    }completion:^(BOOL finished) {
        [UIView animateWithDuration:.25 animations:^{
            
            //obj.alpha=0;
        }];
    }];
}

-(void)okLetsHaveFunForXs:(BOOL)isItVertical{
    chosenIdx=[NSMutableArray new];

    for (UIView*v  in self.view.subviews) {
        if ([v isKindOfClass:[UIImageView class]]) {
            [v removeFromSuperview];
        }
    }
//    _viewToAnimate.hidden=YES;
    
    
     ArrayOfImages =[NSMutableArray new] ;
    float xd=30;
    if (isItVertical) {
        for (float x =0; x<_viewToAnimate.width; x+=xd) {
            for (float y =0; y<_viewToAnimate.height; y+=xd) {
                NSLog(@"xpoint is %f",x);
                MOImageView *newImageView =[self imageFromImageView:_viewToAnimate width:xd height:xd xpoint:x ypoint:y]   ;
//               NSLog(@"newimage bef is %@",NSStringFromCGRect(newImageView.frame));
                [newImageView setWidth:_viewToAnimate.width];
                [newImageView setHeight:_viewToAnimate.height];
                static float margin=0;
                static float marginy=0;
                if (newImageView.XPoint ==0) {
                    margin=0;
                }else{
                    margin=xd;
//                    [newImageView setBackgroundColor:[UIColor yellowColor]];
                }
                if (newImageView.YPoint == 0) {
                    marginy=0;
                }else{
                    marginy=xd;
//                    [newImageView setBackgroundColor:[UIColor blueColor]];
                }
                [newImageView setXPoint:( x-xd*(x/xd) )+ _viewToAnimate.XPoint+newImageView.XPoint-margin*x/xd ];
                [newImageView setYPoint:( y-xd*(y/xd))+ _viewToAnimate.YPoint+newImageView.YPoint -marginy*y/xd ];
                newImageView.originalFrame=newImageView.frame;
//              NSLog(@"newimage frame is %@\n----------",NSStringFromCGRect(newImageView.frame));
                [self.view addSubview:newImageView];
                [ArrayOfImages addObject:newImageView];
                [orImages addObject:newImageView];
                
            }
            
            //    [newImageView setBackgroundColor:[UIColor blueColor]];
            
        }
    }
        
    __block BOOL firstTime=YES;
    [chosenImages removeAllObjects];
    [ArrayOfImages enumerateObjectsUsingBlock:^(MOImageView* obj, NSUInteger idx, BOOL *stop) {
        
        int count =ArrayOfImages.count;
        
        float after =(count-idx)*.02;
        
     //   [self performSelector:@selector(animateimage:) withObject:obj afterDelay:after];
          [self animateimage:obj];
        firstTime=NO;
        
        
        
    }];
    
    
  //  NSLog(@"chosen images %@ count %i",chosenIdx,chosenIdx.count);
    [_viewToAnimate removeFromSuperview];
    
    
    
}

- (MOImageView*)imageFromImageView:(UIImageView*)imageView width:(float)width height:(float)height xpoint:(float)xpoint ypoint:(float)ypoint
{
    CGSize  newSize =imageView.frame.size;
    // NSLog(@"layer of imageview is %@",NSStringFromCGRect (CGRectMake(xpoint, 0, width, height)));
    CALayer *newLayer = imageView.layer  ;
    // [newLayer setFrame:CGRectMake(xpoint, ypoint, imageView.width, imageView.height)];
//    UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);

    CGContextRef context = UIGraphicsGetCurrentContext();
    //   CGContextRotateCTM(context, 2*M_PI);
    CGRect newframe =CGRectMake(xpoint, ypoint, width, height);
    CGContextClipToRect (context,newframe);
    
    [newLayer renderInContext:context];
    UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
    MOImageView *imv =[[MOImageView alloc]initWithImage:image];
    imv.orX=xpoint;
  
    imv.orY=ypoint;
    if (imv.orX==240) {
        NSLog(@"special frame %@",NSStringFromCGRect(newframe));
    }
    [imv setFrame:newframe];
    UIGraphicsEndImageContext();
    
    return imv;
}

-(UIImage*)convertViewIntoImage{
     if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(_viewToAnimate.frame.size, NO, [UIScreen mainScreen].scale*.5);
    else
        UIGraphicsBeginImageContext(_viewToAnimate.bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [_viewToAnimate.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    //UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    UIGraphicsEndImageContext();
    
    
    return img;
}




- (IBAction)revert:(id)sender {
    for (UIView*v  in self.view.subviews) {
        if ([v isKindOfClass:[UIImageView class]]) {
            [v removeFromSuperview];
        }
    }
    [chosenImages enumerateObjectsUsingBlock:^(MOImageView* obj, NSUInteger idx, BOOL *stop) {
        
        
         //   [self performSelector:@selector(animateimage:) withObject:obj afterDelay:after];
        [self ranimateimage:obj index:idx];
        
        
        
    }];
    
    
}
- (void)ranimateimage:(MOImageView *)obj index:(int)idx {
    [UIView animateWithDuration:1.25  animations:^{
        //[obj setYPoint:obj.YPoint+100];
        // NSLog(@"array count %i",ArrayOfImages.count);
 
        obj.frame=obj.originalFrame;
        [self.view addSubview:obj];
        
//        MOImageView *chpsenimg=(MOImageView*)[ArrayOfImages objectAtIndex:idx];
//        
//        NSLog(@"revert ,cObj %@ \n with %@",NSStringFromCGRect(obj.frame),NSStringFromCGRect(chpsenimg.frame));
//        // obj.frame=[chpsenimg frame];
//        float newX =(obj.orX -chpsenimg.orX)-0;
//        float newy =obj.orY-chpsenimg.orY;
//        
//        
//        
////        obj.XPoint =obj.XPoint-newX;
////        obj.YPoint=obj.YPoint-newy;
//        
//        
////        obj.XPoint =chpsenimg.XPoint;
////        obj.YPoint=chpsenimg.YPoint;
//        [chpsenimg setFrame:obj.frame];
//        chpsenimg.XPoint=obj.XPoint;
//        chpsenimg.YPoint=obj.YPoint;
//        obj.XPoint =chpsenimg.XPoint;
//        static int count =0;
//        if (count==chosenImages.count-1) {
//            count=0;
//        }
//        if (count==0) {
//            obj.YPoint+=10;
//
//        }
//        count++;
       // [ArrayOfImages replaceObjectAtIndex:[ArrayOfImages indexOfObject:obj] withObject: obj ];
        //chpsenimg.YPoint+=200;
        
        
        //             NSLog(@"new index is %i,cfr %@\n ,,new frame %@",index,NSStringFromCGRect( obj.frame),NSStringFromCGRect( chpsenimg.frame));
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:.25 animations:^{
            
            //obj.alpha=0;
        }];
    }];
}

@end
