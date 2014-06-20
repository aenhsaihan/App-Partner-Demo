//
//  AnimationViewController.m
//  AppPartnerDemo
//
//  Created by Aditya Narayan on 6/17/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import "AnimationViewController.h"
#import "UIColor+HexString.h"

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)spinButtonPressed:(id)sender {
    
    [self runSpinAnimationOnView:self.logo duration:1.0 rotations:1 repeat:1.0];
    
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
