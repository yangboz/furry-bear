//
//  PopupManager_DTAlertView.m
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-20.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "PopupManager_DTAlertView.h"

@implementation PopupManager_DTAlertView

//It declares a static instance of your singleton object and initializes it to nil.
static PopupManager_DTAlertView *sharedInstance = nil;
static DTAlertView *progressAlertView = nil;
static NSString *curCateItemId = nil;

//In your class factory method for the class (named something like “sharedInstance” or “sharedManager”), it generates an instance of the class but only if the static instance is nil.
+(PopupManager_DTAlertView *)sharedInstance
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
    //set tag to differ
    [alertView setTag:0];
    //
    [alertView show];
}

-(void)popupFriendTalk
{
    DTAlertView *alertView = nil;
    alertView = [DTAlertView alertViewWithTitle:NSLocalizedString(@"T_FRIEND_INV", nil) message:NSLocalizedString(@"ST_FRIEND_REQ", nil) delegate:self cancelButtonTitle:@"Cancel" positiveButtonTitle:@"OK"];
    [alertView setAlertViewMode:DTAlertViewModeTextInput];
    //set tag to differ
    [alertView setTag:1];
    //
    [alertView show];
}

#pragma mark - DTAlertView Delegate Methods

- (void)alertView:(DTAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //
    NSLog(@"You click button title : %@", alertView.clickedButtonTitle);
    //Clicked cancel button to dismiss
    if (buttonIndex == alertView.cancelButtonIndex) {
        [alertView dismiss];
        //
        return;
    }
    //Say nothing
    if ([alertView.textField.text  isEqual: @""]) {
        [alertView dismiss];
        //
        return;
    }
    //
    NSLog(@"Inputed Text : %@", alertView.textField.text);
    //App42_API_call prepare
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    NSString *buddyName = [[UserModel sharedInstance] getBuddyName];
    NSString *message = alertView.textField.text;
    if (alertView.tag==0) {
        //sendFriendRequestFromUser
        [[App42_API_Facade sharedInstance] sendFriendRequestFromUser:userName toBuddy:buddyName withMessage:message];
        //
        [alertView dismiss];
        
        return;
    }else if (alertView.tag==1)
    {
        //sendMessageToFriend
        [[App42_API_Facade sharedInstance] sendMessage:message toFriend:buddyName fromUser:userName];
        //
        [alertView dismiss];
        
        return;
    }else if (alertView.tag==2)
    {
        //App42_API_Facade:reviewCateItem
        [[App42_API_Facade sharedInstance] addReview:curCateItemId reviewComment:message reviewRating:1.0];
        //
        [alertView dismiss];
        
        return;
    }
    //cancelPreviousPerformRequestsWithTarget
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end
