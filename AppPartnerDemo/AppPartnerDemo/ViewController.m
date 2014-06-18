//
//  ViewController.m
//  AppPartnerDemo
//
//  Created by Aditya Narayan on 6/17/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+HexString.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set the image for the back bar button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"button_backarrow.png"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"button_backarrow.png"];

    
    [self.codingTasksLabel setFont:[UIFont fontWithName:@"Machinato-Bold" size:22.0]];
    [self.codingTasksLabel setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
