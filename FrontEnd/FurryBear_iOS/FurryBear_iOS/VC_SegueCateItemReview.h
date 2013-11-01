//
//  VC_SegueCateItemReview.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-11-1.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>
#import "App42_API_Utils.h"
#import "ItemDataModel.h"
#import "StorageModel.h"

@interface VC_SegueCateItemReview : UITableViewController
{}
- (IBAction)on_review_item:(id)sender;
@property (retain, nonatomic) IBOutlet UISlider *slider_rating;
@property (retain, nonatomic) IBOutlet UITextView *itemCommentsTxtView;
@end
