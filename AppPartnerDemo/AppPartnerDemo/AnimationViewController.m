//
//  AnimationViewController.m
//  AppPartnerDemo
//
//  Created by Aditya Narayan on 6/17/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import "AnimationViewController.h"
#import "UIColor+HexString.h"
#import <QuartzCore/QuartzCore.h>

@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"ANIMATION";
    
    self.animationPromptLabel.text = @"Animate the App Partner icon. Make it spin around 360 degrees when the spin button is pressed. Allow it to be dragged around the screen by touching and dragging.";
    [self.animationPromptLabel setFont:[UIFont fontWithName:@"Machinato-ExtraLight" size:16.0]]; //FIXME: Font size for animation prompt
    [self.animationPromptLabel setTextColor:[UIColor colorWithHexString:@"000000"]];
    
    self.animationBonusLabel.text = @"BONUS POINTS FOR CREATIVITY";
    [self.animationBonusLabel setFont:[UIFont fontWithName:@"Machinato-SemiBoldItalic" size:14.0]];  //FIXME: Font size for animation bonus
    [self.animationBonusLabel setTextColor:[UIColor colorWithHexString:@"000000"]];
    
    self.logo.userInteractionEnabled = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touch handling


/**
 Scale and rotation transforms are applied relative to the layer's anchor point this method moves a gesture recognizer's view's anchor point between the user's fingers.
 */
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}


/**
 Shift the piece's center by the pan amount.
 Reset the gesture recognizer's translation to {0, 0} after applying so the next callback is a delta from the current position.
 */
- (IBAction)panPiece:(UIPanGestureRecognizer *)gestureRecognizer {
    
    UIView *piece = [gestureRecognizer view];
    
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}

/**
 Rotate the piece by the current rotation.
 Reset the gesture recognizer's rotation to 0 after applying so the next callback is a delta from the current rotation.
 */
- (IBAction)rotatePiece:(UIRotationGestureRecognizer *)gestureRecognizer {
    
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformRotate([[gestureRecognizer view] transform], [gestureRecognizer rotation]);
        [gestureRecognizer setRotation:0];
    }
}

/**
 Ensure that the pinch, pan and rotate gesture recognizers on a particular view can all recognize simultaneously.
 Prevent other gesture recognizers from recognizing simultaneously.
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // If the gesture recognizers's view isn't the logo, don't allow simultaneous recognition.
    if (gestureRecognizer.view != self.logo) {
        return NO;
    }
    
    // If the gesture recognizers are on different views, don't allow simultaneous recognition.
    if (gestureRecognizer.view != otherGestureRecognizer.view) {
        return NO;
    }
    
    // If either of the gesture recognizers is the long press, don't allow simultaneous recognition.
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return NO;
    }
    
    return YES;
}

/**
 Scale the piece by the current scale.
 Reset the gesture recognizer's rotation to 0 after applying so the next callback is a delta from the current scale.
 */
- (IBAction)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer {
    
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
        [gestureRecognizer setScale:1];
    }
}

#pragma mark - Spinning code

- (IBAction)spinButtonPressed:(id)sender {
    
    [self rotateSpinningView];
    
}

- (void)rotateSpinningView
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.logo setTransform:CGAffineTransformRotate(self.logo.transform, M_PI_2)];
    } completion:^(BOOL finished) {
        if (finished && !CGAffineTransformEqualToTransform(self.logo.transform, CGAffineTransformIdentity)) {
            [self rotateSpinningView];
        }
    }];
}

@end
