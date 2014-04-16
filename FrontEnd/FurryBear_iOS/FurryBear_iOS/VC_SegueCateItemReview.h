//
//  VC_SegueCateItemReview.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-11-1.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App42_API_Facade.h"

@interface VC_SegueCateItemReview : UITableViewController
{}
//IBOutlets
@property (retain, nonatomic) IBOutlet UISlider *slider_rating;
@property (retain, nonatomic) IBOutlet UITextView *itemCommentsTxtView;
//IBActions
- (IBAction)on_review_item:(id)sender;
@end
