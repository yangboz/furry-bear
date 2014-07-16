//
//  PopupManager_AlertTable.m
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-25.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "PopupManager_AlertTable.h"

@interface PopupManager_AlertTable ()

@end

@implementation PopupManager_AlertTable

//It declares a static instance of your singleton object and initializes it to nil.
static PopupManager_AlertTable *sharedInstance = nil;
static ServiceAPI *serviceAPIobj = nil;//Your static instance

//In your class factory method for the class (named something like “sharedInstance” or “sharedManager”), it generates an instance of the class but only if the static instance is nil.
+(PopupManager_AlertTable *)sharedInstance
{
	if (sharedInstance==nil) {
		sharedInstance = [[super allocWithZone:NULL] init];
        //
        serviceAPIobj = [[ServiceAPI alloc] init];
        
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

//implementations
#pragma mark - Interface implementations

//AllFriendRequestView
-(void)popupAllFriendRequests;
{
    //1.Get friend request
    dataMutableArray = [[UserModel sharedInstance] getFriendRequests];
    if(dataMutableArray.count)
    {
    //2.Popup view
    tableAlertView	= [[SBTableAlert alloc] initWithTitle:@"Friend Requests" cancelButtonTitle:@"OK" messageFormat:nil];
    //    [alert.view setTag:1];
    [tableAlertView setStyle:SBTableAlertStylePlain];
    [tableAlertView setType:SBTableAlertTypeMultipleSelct];
    [tableAlertView setDelegate:self];
    [tableAlertView setDataSource:self];
    [tableAlertView show];
    }
}
#pragma mark - SBTableAlertDataSource

- (UITableViewCell *)tableAlert:(SBTableAlert *)tableAlert cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;
	
	if (tableAlert.view.tag == 0 || tableAlert.view.tag == 1) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
	} else {
		// Note: SBTableAlertCell
		cell = [[[SBTableAlertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
	}
	//Set text label with friend request
    
    Buddy *buddy = (Buddy *)[dataMutableArray objectAtIndex:indexPath.row ];
	cell.textLabel.text = buddy.buddyName;
    cell.detailTextLabel.text =
    [[App42_API_Utils sharedInstance] getFormattedDate:buddy.sendedOn];
	
	return cell;
}

- (NSInteger)tableAlert:(SBTableAlert *)tableAlert numberOfRowsInSection:(NSInteger)section {
    /*
	if (tableAlert.type == SBTableAlertTypeSingleSelect)
		return 3;
	else
		return 10;
     */
    return [dataMutableArray count];
}

- (NSInteger)numberOfSectionsInTableAlert:(SBTableAlert *)tableAlert {
	if (tableAlert.view.tag == 3)
		return 2;
	else
		return 1;
}

- (NSString *)tableAlert:(SBTableAlert *)tableAlert titleForHeaderInSection:(NSInteger)section {
	if (tableAlert.view.tag == 3)
		return [NSString stringWithFormat:@"Section Header %d", section];
	else
		return nil;
}

#pragma mark - SBTableAlertDelegate

- (void)tableAlert:(SBTableAlert *)tableAlert didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableAlert.type == SBTableAlertTypeMultipleSelct) {
		UITableViewCell *cell = [tableAlert.tableView cellForRowAtIndexPath:indexPath];
		if (cell.accessoryType == UITableViewCellAccessoryNone)
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            NSLog(@"selectedBuddy:%@",dataMutableArray);
            //Accept friend request
            Buddy *selectedBuddy = (Buddy *)[dataMutableArray objectAtIndex:indexPath.row ];
            //
            NSString *buddyName = selectedBuddy.buddyName;
            Buddy *buddy = [buddyService acceptFriendRequestFromBuddy:buddyName toUser:buddyName];
            NSLog(@"userName is :%@",buddy.userName);
            NSLog(@"buddyName is :%@",buddy.buddyName);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSLog(@"sendedOn is :%@",[formatter stringFromDate:buddy.sendedOn]);
            NSLog(@"acceptedOn is :%@",[formatter stringFromDate:buddy.acceptedOn]);
		}else{
			[cell setAccessoryType:UITableViewCellAccessoryNone];
        }
		
		[tableAlert.tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

- (void)tableAlert:(SBTableAlert *)tableAlert didDismissWithButtonIndex:(NSInteger)buttonIndex {
	NSLog(@"Dismissed: %i", buttonIndex);
	
	[tableAlert release];
}

@end
