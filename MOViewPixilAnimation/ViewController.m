//
//  ViewController.m
//  MOViewPixilAnimation
//
//  Created by moath othman on 1/28/14.
//  Copyright (c) 2014 moath othman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor orangeColor]];
    UIView *someV1= [[UIView alloc]init];
    [someV1 setWidth:20];
    [someV1 setHeight:30];
    [someV1 setBackgroundColor:[UIColor redColor]];
    [_viewToAnimate addSubview:someV1];
    [_viewToAnimate setBackgroundColor:[UIColor greenColor]];
    
    
    UIView *someV2= [[UIView alloc]init];
    [someV2 setWidth:60];
    [someV2 setHeight:30];
    [someV2 setXPoint:40];
    [someV2 setBackgroundColor:[UIColor blackColor]];
    [_viewToAnimate addSubview:someV2];
    
    UIView *someV3= [[UIView alloc]init];
    [someV3 setWidth:60];
    [someV3 setHeight:30];
    [someV3 setXPoint:50];
    [someV3 setYPoint:30];
    [someV3 setBackgroundColor:[UIColor grayColor]];
    [_viewToAnimate addSubview:someV3];
   
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)animateimage:(UIImageView *)obj {
    [UIView animateWithDuration:.25  animations:^{
        [obj setYPoint:obj.YPoint+100];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:.25 animations:^{
            //obj.alpha=0;
        }];
    }];
}

-(void)okLetsHaveFunForXs:(BOOL)isItVertical{
    for (UIView*v  in self.view.subviews) {
        if ([v isKindOfClass:[UIImageView class]]) {
            [v removeFromSuperview];
        }
    }
    UIImageView *imageView =[[UIImageView alloc]initWithImage:[self convertViewIntoImage]];
    [imageView setYPoint:100];
    [imageView setXPoint:60];
    [self.view addSubview:imageView];
    
    NSMutableArray *ArrayOfImages =[NSMutableArray new] ;
     float xd=10;
    if (isItVertical) {
        for (float x =0; x<=200; x+=xd) {
            for (float y =0; y<=100; y+=xd) {
                UIImageView *newImageView =[[UIImageView alloc]initWithImage:[self imageFromImageView:imageView width:xd height:xd xpoint:x ypoint:y]  ];
                [newImageView setXPoint:( x-xd*(x/xd)-1)+60 ];
                [newImageView setYPoint:( y-xd*(y/xd)-1)+200  ];
                [self.view addSubview:newImageView];
                [ArrayOfImages addObject:newImageView];
            }
            
            //    [newImageView setBackgroundColor:[UIColor blueColor]];
            
        }
    }
    else{
       
            for (float y =0; y<=100; y+=xd) {
                 for (float x =0; x<=200; x+=xd) {
                UIImageView *newImageView =[[UIImageView alloc]initWithImage:[self imageFromImageView:imageView width:xd height:xd xpoint:x ypoint:y]  ];
                [newImageView setXPoint:( x-xd*(x/xd)-1)+60 ];
                [newImageView setYPoint:( y-xd*(y/xd)-1)+200  ];
                [self.view addSubview:newImageView];
                [ArrayOfImages addObject:newImageView];
            }
            
            //    [newImageView setBackgroundColor:[UIColor blueColor]];
            
        }
    }
  
   __block BOOL firstTime=YES;
    [ArrayOfImages enumerateObjectsUsingBlock:^(UIImageView* obj, NSUInteger idx, BOOL *stop) {
        
        int count =ArrayOfImages.count;
       
        float after =(count-idx)*.02;
        
        [self performSelector:@selector(animateimage:) withObject:obj afterDelay:after];
      //  [self animateimage:obj];
        firstTime=NO;
        
    
 
    }];

    [_viewToAnimate removeFromSuperview];
    
    
    
}

- (UIImage*)imageFromImageView:(UIImageView*)imageView width:(float)width height:(float)height xpoint:(float)xpoint ypoint:(float)ypoint
{
    CGSize  newSize =imageView.frame.size;
   // NSLog(@"layer of imageview is %@",NSStringFromCGRect (CGRectMake(xpoint, 0, width, height)));
    CALayer *newLayer = imageView.layer  ;
   // [newLayer setFrame:CGRectMake(xpoint, ypoint, imageView.width, imageView.height)];
    UIGraphicsBeginImageContext(newSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
 //   CGContextRotateCTM(context, 2*M_PI);
    CGContextClipToRect (UIGraphicsGetCurrentContext(),CGRectMake(xpoint, ypoint, width, height));

    [newLayer renderInContext:context];
    UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage*)convertViewIntoImage{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(_viewToAnimate.frame.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(keyWindow.bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [_viewToAnimate.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    UIGraphicsEndImageContext();
    
    
    return img;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animate:(id)sender {
    
     [self okLetsHaveFunForXs:YES];
    
}

- (IBAction)cropAnimationHorizontally:(UIButton *)sender {
    [self okLetsHaveFunForXs:NO];

    
    
}
@end
