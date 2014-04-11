//
//  ViewController.m
//  RotateGestureWithOneFinger
//
//  Created by Barty Kim on 4/10/14.
//  Copyright (c) 2014 bartysways. All rights reserved.
//

#import "ViewController.h"
#import "BTBOneFingerRotationGestureReconizer.h"

#pragma mark - Interface extension of 'ViewController'

@interface ViewController ()<BTBOneFingerRotationGestureReconizerDelegate>

@property(nonatomic, strong) UIImageView *imageView;

@end


#pragma mark - Implementation of 'ViewController'

@implementation ViewController
{
    CGFloat imageAngle;
    BTBOneFingerRotationGestureReconizer *_gestureRecognizer;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        // Custom initialization
        imageAngle = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIImage *img = [UIImage imageNamed:@"sample2.jpeg"];
    _imageView = [[UIImageView alloc] initWithImage:img];
    [self.view addSubview:_imageView];
    
    [self setupGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Selectors

- (void) setupGestureRecognizer
{
    CGPoint midPoint = CGPointMake(self.view.frame.origin.x + self.view.frame.size.width / 2,
                                   self.view.frame.origin.y + self.view.frame.size.height / 2);
    
    _gestureRecognizer = [[BTBOneFingerRotationGestureReconizer alloc]
                          initWithMidPoint:midPoint delegate:self];
    
    [self.view addGestureRecognizer: _gestureRecognizer];
}



#pragma mark - Delegate of 'BTBOneFingerRotationGestureReconizer'

- (void) rotation: (CGFloat) angle
{
    imageAngle += angle;
    if (imageAngle > 360)
        imageAngle -= 360;
    else if (imageAngle < -360)
        imageAngle += 360;
    
    _imageView.transform = CGAffineTransformMakeRotation(imageAngle *  M_PI / 180);

}



@end
