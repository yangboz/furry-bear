//
//  VC_FeedCateItemDetail.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-5-6.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
//
#import "App42_API_Facade.h"
//RetractableSectionControllers
#import "GCSimpleSectionController.h"
#import "GCCustomSectionController.h"
#import "GCArraySectionController.h"
#import "GCEmptySectionController.h"

@interface VC_FeedCateItemDetail : UITableViewController
{}
//Properties
@property(nonatomic,retain) categoryItem *cateItemData;
//@see https://github.com/gcamp/GCRetractableSectionController#readme
@property (nonatomic,retain) NSArray *retractableControllers;
//
@end
