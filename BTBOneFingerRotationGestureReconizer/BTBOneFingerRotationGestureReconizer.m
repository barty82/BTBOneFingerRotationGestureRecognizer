//
//  BTBOneFingerRotationGestureReconizer.m
//  RotateGestureWithOneFinger
//
//  Created by Barty Kim on 4/10/14.
//  Copyright (c) 2014 bartysways. All rights reserved.
//

#import "BTBOneFingerRotationGestureReconizer.h"
#include <math.h>


#pragma mark - Interface extention of 'BTBOneFingerRotationGestureReconizer'

@interface BTBOneFingerRotationGestureReconizer ()
@end


#pragma mark - Implementation of 'BTBOneFingerRotationGestureReconizer'

@implementation BTBOneFingerRotationGestureReconizer
{
    CGFloat _cumulatedAngle;
    CGPoint _midPoint;
}

#pragma mark - Math Helper functions

CGFloat angleBetweenLinesInDegrees(CGPoint beginLineA,
                                   CGPoint endLineA,
                                   CGPoint beginLineB,
                                   CGPoint endLineB)
{
    CGFloat a = endLineA.x - beginLineA.x;
    CGFloat b = endLineA.y - beginLineA.y;
    CGFloat c = endLineB.x - beginLineB.x;
    CGFloat d = endLineB.y - beginLineB.y;
    
    CGFloat atanA = atan2(a, b);
    CGFloat atanB = atan2(c, d);
    
    // convert radiants to degrees
    return (atanA - atanB) * 180 / M_PI;
}


#pragma mark - Life cycle

- (id) initWithMidPoint:(CGPoint)midPoint
                 delegate:(id <BTBOneFingerRotationGestureReconizerDelegate>)target
{
    if ((self = [super initWithTarget:target action: nil]))
    {
        _midPoint = midPoint;
        _target = target;
    }
    return self;
}


#pragma mark - Override methods

- (void)reset
{
    [super reset];
    _cumulatedAngle = 0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    //Detecting only one finger.
    if ([touches count] != 1)
    {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStateFailed) return;
    
    CGPoint nowPoint  = [[touches anyObject] locationInView: self.view];
    CGPoint prevPoint = [[touches anyObject] previousLocationInView: self.view];
    
    CGFloat angle = angleBetweenLinesInDegrees(_midPoint, prevPoint, _midPoint, nowPoint);
    
    if (angle > 180)
        angle -= 360;
    else if (angle < -180)
        angle += 360;
    
    
    _cumulatedAngle += angle;
    
    if (![_target respondsToSelector: @selector(rotation:)])
        return;
    
    [_target rotation:angle];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStatePossible)
    {
        self.state = UIGestureRecognizerStateRecognized;
        
        if ([_target respondsToSelector: @selector(finalAngle:)])
            [_target finalAngle:_cumulatedAngle];
    }
    else
        self.state = UIGestureRecognizerStateFailed;
    
    _cumulatedAngle = 0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    self.state = UIGestureRecognizerStateFailed;
    _cumulatedAngle = 0;
}


@end
