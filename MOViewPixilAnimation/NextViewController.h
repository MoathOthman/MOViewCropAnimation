//
//  NextViewController.h
//  MOViewPixilAnimation
//
//  Created by moath othman on 1/29/14.
//  Copyright (c) 2014 moath othman. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <stdlib.h>
#import "MOImageView.h"
@interface NextViewController : UIViewController{
    NSMutableArray *ArrayOfImages;
}
- (IBAction)cropAndShuffle:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *viewToAnimate;
- (IBAction)revert:(id)sender;

@end
