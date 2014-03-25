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
//CateItemDetailView
-(void)popupCateItemDetail;
{
    SBTableAlert *alert;
	alert	= [[SBTableAlert alloc] initWithTitle:@"Item Review" cancelButtonTitle:@"OK" messageFormat:nil];
    //    [alert.view setTag:1];
    //    [alert setDelegate:self];
    //	[alert setDataSource:self];
	[alert show];
}
//AllFriendRequestView
-(void)popupAllFriendRequest;
{
    
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
	
	[cell.textLabel setText:[NSString stringWithFormat:@"Cell %d", indexPath.row]];
	
	return cell;
}

- (NSInteger)tableAlert:(SBTableAlert *)tableAlert numberOfRowsInSection:(NSInteger)section {
    /*
	if (tableAlert.type == SBTableAlertTypeSingleSelect)
		return 3;
	else
		return 10;
     */
    return 0;
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
			[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
		else
			[cell setAccessoryType:UITableViewCellAccessoryNone];
		
		[tableAlert.tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

- (void)tableAlert:(SBTableAlert *)tableAlert didDismissWithButtonIndex:(NSInteger)buttonIndex {
	NSLog(@"Dismissed: %i", buttonIndex);
	
	[tableAlert release];
}

@end
