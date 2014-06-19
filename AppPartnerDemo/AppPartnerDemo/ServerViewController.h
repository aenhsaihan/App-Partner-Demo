//
//  ServerViewController.h
//  AppPartnerDemo
//
//  Created by Aditya Narayan on 6/17/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *niceLabel;
@property (weak, nonatomic) IBOutlet UILabel *millisecondsLabel;

- (IBAction)pingServer:(id)sender;

@end
