//
//  PopupManager.m
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-20.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "PopupManager.h"

@implementation PopupManager

//It declares a static instance of your singleton object and initializes it to nil.
static PopupManager *sharedInstance = nil;
static DTAlertView *progressAlertView = nil;

//In your class factory method for the class (named something like “sharedInstance” or “sharedManager”), it generates an instance of the class but only if the static instance is nil.
+(PopupManager *)sharedInstance
{
	if (sharedInstance==nil) {
		sharedInstance = [[super allocWithZone:NULL] init];
        //With loading HUD
        DTAlertViewButtonClickedBlock block = ^(DTAlertView *_alertView, NSUInteger buttonIndex, NSUInteger cancelButtonIndex){
            if (buttonIndex == cancelButtonIndex) {
                [NSObject cancelPreviousPerformRequestsWithTarget:self];
            }
        };
        //Configure the AlertView;
        progressAlertView = [DTAlertView alertViewUseBlock:block title:@"Loading..." message:nil cancelButtonTitle:@"Cancel" positiveButtonTitle:nil];
        [progressAlertView setAlertViewMode:DTAlertViewModeProgress];
        [progressAlertView setPercentage:0];
	}
    //
	return sharedInstance;
}
//It overrides the allocWithZone: method to ensure that another instance is not allocated if someone tries to allocate and initialize an instance of your class directly instead of using the class factory method. Instead, it just returns the shared object.
+(id)allocWithZone:(NSZone *)zone
{
	return [ [self sharedInstance] retain];
}
//It implements the base protocol methods copyWithZone:, release, retain, retainCount, and autorelease to do the appropriate things to ensure singleton status. (The last four of these methods apply to memory-managed code, not to garbage-collected code.)
-(id)copyWithZone:(NSZone *)zone
{
	return self;
}

-(id)retain
{
	return self;
}

-(NSUInteger)retainCount
{
	return NSUIntegerMax;//denotes an object that cannot be released.
}

//-(void)release
//{
//	//do nothing.
//}

#pragma mark - DTAlertView
- (void)popupProgressBar
{
    //
    [progressAlertView show];
    //
    //[self performSelector:@selector(changePercentage:) withObject:@(0.2f) afterDelay:1.0f];
    //
}
- (void)dismissProgressBar
{
    [progressAlertView dismiss];
}
- (void)changePercentage:(NSNumber *)percentage
{
    CGFloat _percentage = [percentage floatValue];
    
    [progressAlertView setPercentage:_percentage];
    //
    if (_percentage < 1.0f) {
        [self performSelector:@selector(changePercentage:) withObject:@(_percentage + 0.1f) afterDelay:1.0f];
    } else {
        [progressAlertView dismiss];
    }
}

#pragma mark -FriendRequest/Invite
//@see http://api.shephertz.com/app42-docs/buddy-management-service/#send_friend_request
//@see http://blogs.shephertz.com/2013/09/05/manage-your-friends-using-app42-buddy-management-api/
-(void)popupFriendRequest
{
    DTAlertView *alertView = nil;
    alertView = [DTAlertView alertViewWithTitle:@"Friend Request" message:@"Say something:" delegate:self cancelButtonTitle:@"Cancel" positiveButtonTitle:@"OK"];
    [alertView setAlertViewMode:DTAlertViewModeTextInput];
    [alertView show];
}

-(void)popupFriendInvite
{
    
}

#pragma mark - DTAlertView Delegate Methods

- (void)alertView:(DTAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //
    NSLog(@"You click button title : %@", alertView.clickedButtonTitle);
    //
    if (alertView.textField != nil) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            [alertView dismiss];
            //
            return;
        }
        //
        NSLog(@"Inputed Text : %@", alertView.textField.text);
        //
        NSString *userName = [[[UserModel sharedInstance] getUser] userName];
        NSString *buddyName = [[UserModel sharedInstance] getBuddyName];
        NSString *message = alertView.textField.text;
        BuddyService *buddyService  = [[App42_API_Utils sharedInstance] getBuddyService];
        Buddy *buddy = [buddyService sendFriendRequestFromUser:userName toBuddy:buddyName withMessage:message];
        NSLog(@"userName is : %@", buddy.userName);
        NSLog(@"buddyName is : %@", buddy.buddyName);
        NSLog(@"message is : %@", buddy.message);
        NSLog(@"sendedOn is : %@", buddy.sendedOn);
        //
        [alertView dismiss];
        
        return;
    }
    //
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}
#pragma mark -CateItemDetailView
-(void)popupCateItemDetail
{
    // Create alertView with the old fashioned way.
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:@"Steven Jobs" message:@"\"Steven Paul Jobs, the co-founder, two-time CEO, and chairman of Apple Inc., died October 5, 2011, after a long battle with cancer. He was 56. He was is survived by his wife and four children.The achievements in Jobs' career included helping to popularize the personal computer, leading the development of groundbreaking technology products including the Macintosh, iPod, and iPhone, and driving Pixar Animation Studios to prominence. Jobs’ charisma, drive for success and control, and vision contributed to revolutionary changes in the way technology integrates into and affects the daily life of most people in the world.\" - Wikipedia" cancelButtonTitle:nil];
    // Add additional button as you like with block to handle UIControlEventTouchUpInside event.
    [alertView addButtonWithTitle:@"Dismiss"
                             type:CXAlertViewButtonTypeCancel
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              // Dismiss alertview
                              [alertView dismiss];
                          }];
    
    // This is a demo for changing content at realtime.
    [alertView addButtonWithTitle:@"Taipei 101"
                             type:CXAlertViewButtonTypeDefault
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              alertView.title = @"Taipei 101";
                              UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"taipei101.jpg"]];
                              imageView.backgroundColor = [UIColor clearColor];
                              alertView.contentView = imageView;
                          }];
    
    // This is a demo for multiple line of title.
    [alertView addButtonWithTitle:@"Multititle"
                             type:CXAlertViewButtonTypeCustom
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              alertView.contentView = nil;
                              alertView.title = @"This \n is \n a \n multiline \n title demo without content.";
                          }];
    
    [alertView addButtonWithTitle:@"Another"
                             type:CXAlertViewButtonTypeDefault
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              alertView.title = @"Red custom view";
                              UIView *view = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, 200, 200)];
                              view.backgroundColor = [UIColor redColor];
                              alertView.contentView = view;
                          }];
    
    [alertView addButtonWithTitle:@"Shake"
                             type:CXAlertViewButtonTypeDefault
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              
                              [alertView shake];
                              
                          }];
    
    // Remember to call this, or alertview will never be seen.
    [alertView show];
}

@end
