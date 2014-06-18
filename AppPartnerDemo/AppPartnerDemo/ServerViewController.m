//
//  ServerViewController.m
//  AppPartnerDemo
//
//  Created by Aditya Narayan on 6/17/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import "ServerViewController.h"
#import "UIColor+HexString.h"

@interface ServerViewController ()

@end

@implementation ServerViewController

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
    
    self.title = @"SERVER PING";
    
    self.niceLabel.text = @"NICE!";
    [self.niceLabel setFont:[UIFont fontWithName:@"Machinato-Light" size:22.0]]; //FIXME: Reconfigure size for NICE!
    [self.niceLabel setTextColor:[UIColor colorWithHexString:@"ff5f21"]];
    
    self.millisecondsLabel.text = @"144.16ms";
    [self.millisecondsLabel setFont:[UIFont fontWithName:@"Machinato-ExtraLightItalic" size:22]]; //FIXME: Reconfigure size for milliseconds
    [self.millisecondsLabel setTextColor:[UIColor colorWithHexString:@"000000"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
