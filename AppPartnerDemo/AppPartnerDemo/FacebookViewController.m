//
//  FacebookViewController.m
//  AppPartnerDemo
//
//  Created by Aditya Narayan on 6/17/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import "FacebookViewController.h"
#import "UIColor+HexString.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "MiddleTableCell.h"

@interface FacebookViewController ()

@end

static int retryCount;

@implementation FacebookViewController

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
    
    self.title = @"FACEBOOK FRIENDS";
    
    self.tableView.layer.cornerRadius = 2;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reloadButtonTouched:(id)sender {
    
    if (![APP_DELEGATE checkForInternetConnection]) {
        return;
    }
    
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        // Note: This part is not necessary for our purposes...
        //[FBSession.activeSession closeAndClearTokenInformation];
        
        [self makeGraphAPICall];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"user_friends"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             APP_DELEGATE.APIRequest = YES;
             
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [APP_DELEGATE sessionStateChanged:session state:state error:error];
             
         }];
    }
}

-(void)makeGraphAPICall
{
    // We will use retryCount as part of the error handling logic for errors that need retries
    retryCount = 0;
    
    FBRequest *friendsRequest = [FBRequest requestForMyFriends];
    
    [friendsRequest startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        if (!error) {
            // Success! Include your code to handle the results here
            
            
            self.friends = [result objectForKey:@"data"];
            NSLog(@"Found: %i friends", self.friends.count);
            for (NSDictionary<FBGraphUser> *friend in self.friends) {
                NSLog(@"I have a friend named %@ with id %@", friend.name, friend.objectID);
            }
            
            [self.tableView reloadData];
            
        } else if (error) {
            // An error occurred, we need to handle the error
            // See: https://developers.facebook.com/docs/ios/errors
            
            [self handleAPICallError:error];
        } else {
            
            retryCount = 0;
        }
    }];
    
}



// Helper method to handle errors during API calls
- (void)handleAPICallError:(NSError *)error
{
    // If the user has removed a permission that was previously granted
    if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryPermissions) {
        NSLog(@"Re-requesting permissions");
        // Ask for required permissions.
        //[self requestPermission];
        return;
    }
    
    // Some Graph API errors need retries, we will have a simple retry policy of one additional attempt
    // We also retry on a throttling error message, a more sophisticated app should consider a back-off period
    retryCount++;
    if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryRetry ||
        [FBErrorUtility errorCategoryForError:error] == FBErrorCategoryThrottling) {
        if (retryCount < 2) {
            NSLog(@"Retrying open graph post");
            // Recovery tactic: Call API again.
            [self makeGraphAPICall];
            return;
        } else {
            NSLog(@"Retry count exceeded.");
            return;
        }
    }
    
    // For all other errors...
    NSString *alertText;
    NSString *alertTitle;
    
    // If the user should be notified, we show them the corresponding message
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Something Went Wrong";
        alertText = [FBErrorUtility userMessageForError:error];
        
    } else {
        // show a generic error message
        NSLog(@"Unexpected error posting to open graph: %@", error);
        alertTitle = @"Something went wrong";
        alertText = @"Please try again later.";
    }
    
    [APP_DELEGATE showMessage:alertText withTitle:alertTitle];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MiddleTableCell";
    MiddleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
    
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MiddleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Configure the cell...
    
    NSDictionary<FBGraphUser> *friend = [self.friends objectAtIndex:indexPath.row];
    
    
    [cell.nameLabel setFont:[UIFont fontWithName:@"Machinato-Regular" size:44.0]];
    [cell.nameLabel setTextColor:[UIColor colorWithHexString:@"#007ae0"]];
    cell.nameLabel.text = friend.name;
    
    UIImage *profilePic = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture", friend.objectID]]]];
    cell.thumbnailImageView.image = profilePic;
    
    
    UIImage *backgroundImage;
    
    if (indexPath.row == 0) {
        
        backgroundImage = [UIImage imageNamed:@"bg_cell_topcap_fbfriends.png"];
        
    } else if (indexPath.row == [self.friends count]) {
        
        backgroundImage = [UIImage imageNamed:@"bg_cell_bottomcap_fbfriends.png"];
        
    } else {
        
        backgroundImage = [UIImage imageNamed:@"bg_cell_middle_fbfriends.png"];
        
    }
    
    cell.backgroundImageView.image = backgroundImage;
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}


@end
