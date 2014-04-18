//
//  PopupManager_AlertTable.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-25.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBTableAlert.h"
#import "App42_API_Facade.h"

@interface PopupManager_AlertTable : UITableViewController<SBTableAlertDataSource,SBTableAlertDelegate>
{
    SBTableAlert *tableAlertView;
    BuddyService *buddyService;
    NSMutableArray *dataMutableArray;//categoryItemReviews,allFriendRequests..
}
+(PopupManager_AlertTable *)sharedInstance;
//CateItemDetailView
-(void)popupCateItemDetail;
//AllFriendRequestView
-(void)popupAllFriendRequests;
@end
