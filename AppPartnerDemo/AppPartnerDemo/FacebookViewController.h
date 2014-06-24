//
//  FacebookViewController.h
//  AppPartnerDemo
//
//  Created by Aditya Narayan on 6/17/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacebookViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *friends;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;


- (IBAction)reloadButtonTouched:(id)sender;
- (void)makeGraphAPICall;

@end
