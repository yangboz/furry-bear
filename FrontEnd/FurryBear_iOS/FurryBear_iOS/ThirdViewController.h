//
//  ThirdViewController.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-9.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>
#import "App42_API_Utils.h"

@interface ThirdViewController : UIViewController<UIImagePickerControllerDelegate>
{}

@property(nonatomic, retain) UIImage *photo;
@property (retain, nonatomic) IBOutlet UIButton *photoButton;
@property (retain, nonatomic) IBOutlet UITextField *filenameTxt;
@property (retain, nonatomic) IBOutlet UITextView *fileDescTxtView;

- (IBAction)uploadPhoto:(id)sender;

- (IBAction)choosePhoto:(id)sender;
@property (retain, nonatomic) IBOutlet UISlider *slider_rating;
@property (retain, nonatomic) IBOutlet UISlider *slider_price;
@property (retain, nonatomic) IBOutlet UITextField *txt_address;
@property (retain, nonatomic) IBOutlet UITextField *txt_restaurant;
@property (retain, nonatomic) IBOutlet UITextField *txt_telephone;
@property (retain, nonatomic) IBOutlet UISwitch *switch_agree;
@property (retain, nonatomic) IBOutlet UIButton *btn_add_item;

- (IBAction)on_add_item:(id)sender;

@end
