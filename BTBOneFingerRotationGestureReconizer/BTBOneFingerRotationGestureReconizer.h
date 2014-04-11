//
//  BTBOneFingerRotationGestureReconizer.h
//  RotateGestureWithOneFinger
//
//  Created by Barty Kim on 4/10/14.
//  Copyright (c) 2014 bartysways. All rights reserved.
//

#import <UIKit/UIGestureRecognizerSubclass.h>

#pragma mark - Protocol of 'BTBOneFingerRotationGestureReconizerDelegate'

@protocol BTBOneFingerRotationGestureReconizerDelegate <NSObject>

@optional
- (void) rotation:(CGFloat)angle;
- (void) finalAngle:(CGFloat)angle;

@end


#pragma mark - Interface of 'BTBOneFingerRotationGestureReconizer'

@interface BTBOneFingerRotationGestureReconizer:UIGestureRecognizer

@property(nonatomic, strong) id<BTBOneFingerRotationGestureReconizerDelegate>target;

- (id) initWithMidPoint:(CGPoint) _midPoint
               delegate:(id <BTBOneFingerRotationGestureReconizerDelegate>)target;

- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;


@end
