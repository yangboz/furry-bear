//
//  VC_SegueCateItemAdd.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-10-23.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>
#import "App42_API_Utils.h"
#import "UserModel.h"
#import "UploadModel.h"

@interface VC_SegueCateItemAdd : UITableViewController
{}
- (IBAction)on_add_item:(id)sender;
@property (retain, nonatomic) IBOutlet UISlider *slider_price;
@end
