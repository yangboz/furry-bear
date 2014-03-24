//
//  VC_BuddyRelated.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-23.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App42_API_Utils.h"
#import "UserModel.h"

@interface VC_BuddyRelated : UITableViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *allFriends;
    BuddyService *buddyService;
}
@end
