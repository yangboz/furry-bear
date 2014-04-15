//
//  VC_SegueCateItemAdd.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-10-23.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App42_API_Facade.h"
#import "MBProgressHUD.h"

@interface VC_SegueCateItemAdd : UITableViewController
{}
- (IBAction)on_add_item:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *addressTxt;
@property (retain, nonatomic) IBOutlet UITextField *resturantTxt;
@property (retain, nonatomic) IBOutlet UITextField *telphoneTxt;
@property (retain, getter=isOn) IBOutlet UISwitch *agreeNextTimeSwitch;
@end
