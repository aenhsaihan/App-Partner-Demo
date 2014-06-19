//
//  ServerViewController.m
//  AppPartnerDemo
//
//  Created by Aditya Narayan on 6/17/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import "ServerViewController.h"
#import "UIColor+HexString.h"
#import "AppDelegate.h"

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
    
    [self.niceLabel setFont:[UIFont fontWithName:@"Machinato-Light" size:22.0]]; //FIXME: Reconfigure size for NICE!
    [self.niceLabel setTextColor:[UIColor colorWithHexString:@"ff5f21"]];
    
    [self.millisecondsLabel setFont:[UIFont fontWithName:@"Machinato-ExtraLightItalic" size:22]]; //FIXME: Reconfigure size for milliseconds
    [self.millisecondsLabel setTextColor:[UIColor colorWithHexString:@"000000"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pingServer:(id)sender {
    
    NSDate *start = [NSDate date];
    
    NSURL *url = [NSURL URLWithString:@"http://ec2-54-243-205-92.compute-1.amazonaws.com/Tests/ping.php"];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0];
    [postRequest setValue:@"EGOT" forHTTPHeaderField:@"Password"];
    [postRequest setHTTPMethod:@"POST"];
    
    [NSURLConnection sendAsynchronousRequest:postRequest queue:[AppDelegate connectionQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            NSLog(@"Error: %@", [connectionError localizedDescription] ? [connectionError localizedDescription] : @"Unknown Error");
        } else if (!response) {
            NSLog(@"Could not reach server!");
        } else if (!data) {
            NSLog(@"Server did not return any data");
        } else {
            
            NSDate *finish = [NSDate date];
            NSTimeInterval elapsedTime = [finish timeIntervalSinceDate:start];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateLabelsWithElapsedTime:(elapsedTime * 1000)];
            });
        }
        
    }];
    
}

-(void)updateLabelsWithElapsedTime:(double)milliseconds
{
    self.niceLabel.text = @"NICE!";

    self.millisecondsLabel.text = [NSString stringWithFormat:@"%.2fms", milliseconds];
}

@end
