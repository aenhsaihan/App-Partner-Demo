//
//  AppDelegate.h
//  AppPartnerDemo
//
//  Created by Aditya Narayan on 6/17/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property BOOL APIRequest;

+(NSOperationQueue *)connectionQueue;

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;

-(void)showMessage:(NSString *)alertText withTitle:(NSString *)alertTitle;

-(BOOL)checkForInternetConnection;

@end
