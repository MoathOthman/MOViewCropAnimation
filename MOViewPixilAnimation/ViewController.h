//
//  ViewController.h
//  MOViewPixilAnimation
//
//  Created by moath othman on 1/28/14.
//  Copyright (c) 2014 moath othman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *viewToAnimate;
@property (strong, nonatomic) IBOutlet UIButton *animate;
- (IBAction)animate:(id)sender;
- (IBAction)cropAnimationHorizontally:(UIButton *)sender;

@end
