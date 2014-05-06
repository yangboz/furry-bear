//
//  PopupManager_DTAlertView.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-20.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTAlertView.h"
#import "App42_API_Utils.h"
#import "UserModel.h"

@interface PopupManager_DTAlertView : UIView <DTAlertViewDelegate>
{}
+(PopupManager_DTAlertView *)sharedInstance;

//ProgressView
-(void)popupProgressBar;
-(void)dismissProgressBar;
//CateItemReview
-(void)popupCateItemReview:(NSString *)cateItemId;
//FriendRequest/Talk
-(void)popupFriendRequest;
-(void)popupFriendTalk;
@end
