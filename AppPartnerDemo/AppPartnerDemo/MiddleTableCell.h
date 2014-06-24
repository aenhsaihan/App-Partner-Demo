//
//  MiddleTableCell.h
//  AppPartnerDemo
//
//  Created by Aditya Narayan on 6/23/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiddleTableCell : UITableViewCell

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


@end
