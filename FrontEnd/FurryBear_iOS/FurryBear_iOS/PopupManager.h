//
//  PopupManager.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-20.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTAlertView.h"
#import "App42_API_Utils.h"
#import "UserModel.h"

@interface PopupManager : UIView <DTAlertViewDelegate>
{}
+(PopupManager *)sharedInstance;

//ProgressView
-(void)popupProgressBar;
-(void)dismissProgressBar;
//FriendRequest/Invite
-(void)popupFriendRequest;
-(void)popupFriendInvite;
//CateItemDetailView
-(void)popupCateItemDetail;
@end
