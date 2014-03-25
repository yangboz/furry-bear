//
//  VC_FriendRequestTable.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-25.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBTableAlert.h"
#import "App42_API_Utils.h"
#import "UserModel.h"

@interface VC_FriendRequestTable : UITableViewController<SBTableAlertDataSource,SBTableAlertDelegate>
{
    NSMutableArray *allFriends;
    BuddyService *buddyService;
}
@end
