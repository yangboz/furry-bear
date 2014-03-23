//
//  VC_BuddyRelated.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-23.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App42_API_Utils.h"

@interface VC_BuddyRelated : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *allFriends;
}
@end
