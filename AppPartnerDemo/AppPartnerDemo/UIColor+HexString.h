//
//  UIColor+HexString.h
//  AppPartnerDemo
//
//  Created by Aditya Narayan on 6/18/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//  Borrowed from: http://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

+ (UIColor *) colorWithHexString:(NSString *) hexString;

@end
