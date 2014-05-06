//
//  VC_CateItemDetail.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-4-7.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App42_API_Facade.h"
#import "AsyncImageView.h"
//RetractableSectionControllers
#import "GCSimpleSectionController.h"

@interface VC_CateItemDetail : UITableViewController
{
}
@property(nonatomic,retain) categoryItem *cateItemData;
//IBOutlets
@property (nonatomic, strong) IBOutlet AsyncImageView *itemImageView;
@property (retain, nonatomic) IBOutlet UITextField *tf_description;
@property (retain, nonatomic) IBOutlet UITextField *tf_price;
@property (retain, nonatomic) IBOutlet UITextField *tf_rating;
@property (retain, nonatomic) IBOutlet UITextField *tf_address;
//@see https://github.com/gcamp/GCRetractableSectionController#readme
@property (nonatomic,retain) NSArray *retractableControllers;

@end
