//
//  VC_SBTableAlertFriendRequests.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-28.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBTableAlert.h"
#import "App42_API_Utils.h"

@interface VC_SBTableAlertFriendRequests: UIViewController
<SBTableAlertDataSource,SBTableAlertDelegate>
{
    NSMutableArray *dataMutableArray;//categoryItemReviews,allFriendRequests..
}
@end
