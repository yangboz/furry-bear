//
//  VC_SegueImageUpload.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-10-23.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>
#import "App42_API_Facade.h"
#import "MBProgressHUD.h"

@interface VC_SegueImageUpload : UITableViewController <UIImagePickerControllerDelegate>
{
    
}
@property(nonatomic, retain) UIImage *photo;
@property (retain, nonatomic) IBOutlet UIButton *photoButton;
@property (retain, nonatomic) IBOutlet UITextField *filenameTxt;
@property (retain, nonatomic) IBOutlet UITextView *fileDescTxtView;
@property (retain, nonatomic) IBOutlet UISlider *slider_price;

- (IBAction)uploadPhoto:(id)sender;
- (IBAction)choosePhoto:(id)sender;
@end
