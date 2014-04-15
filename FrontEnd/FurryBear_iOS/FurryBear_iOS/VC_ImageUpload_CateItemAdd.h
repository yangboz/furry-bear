//
//  VC_ImageUpload_CateItemAdd.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-4-15.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App42_API_Facade.h"
#import "MBProgressHUD.h"

@interface VC_ImageUpload_CateItemAdd : UITableViewController<UIImagePickerControllerDelegate>
{}
//IBOutlets
@property(nonatomic, retain) UIImage *photo;
@property (retain, nonatomic) IBOutlet UIButton *photoButton;
@property (retain, nonatomic) IBOutlet UITextField *filenameTxt;
@property (retain, nonatomic) IBOutlet UITextView *fileDescTxtView;
@property (retain, nonatomic) IBOutlet UISlider *slider_price;
//
@property (retain, nonatomic) IBOutlet UITextField *addressTxt;
@property (retain, nonatomic) IBOutlet UITextField *resturantTxt;
@property (retain, nonatomic) IBOutlet UITextField *telphoneTxt;
@property (retain, getter=isOn) IBOutlet UISwitch *agreeNextTimeSwitch;
//IBActions
- (IBAction)uploadPhoto:(id)sender;
- (IBAction)choosePhoto:(id)sender;
- (IBAction)on_add_item:(id)sender;
@end
