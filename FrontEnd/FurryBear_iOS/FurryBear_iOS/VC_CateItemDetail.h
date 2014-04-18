//
//  VC_CateItemDetail.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-4-7.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App42_API_Facade.h"

@interface VC_CateItemDetail : UITableViewController
{
}
@property(nonatomic,retain) categoryItem *cateItemData;
//IBOutlets
@property (retain, nonatomic) IBOutlet UITextField *tf_description;
@property (retain, nonatomic) IBOutlet UILabel *lbl_price;
@end
