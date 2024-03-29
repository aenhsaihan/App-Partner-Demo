//
//  AnimationViewController.h
//  AppPartnerDemo
//
//  Created by Aditya Narayan on 6/17/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *animationPromptLabel;
@property (weak, nonatomic) IBOutlet UILabel *animationBonusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logo;


- (IBAction)spinButtonPressed:(id)sender;


@end
