//
//  VC_CategoryItemAddReview.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-10-8.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>
#import "Prefs.h"
#import "SCNavigationController.h"
#import "PostViewController.h"

@interface VC_CategoryItemAddReview : UITableViewController <UITableViewDelegate,UITableViewDataSource,SCNavigationControllerDelegate>
{
    SCNavigationController *scNav;
}
@end