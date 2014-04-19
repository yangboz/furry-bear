//
//  VC_ImageUpload_CateItemAdd.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-4-15.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App42_API_Facade.h"
#import "NYSliderPopover.h"
#import "EDStarRating.h"

@interface VC_ImageUpload_CateItemAdd : UITableViewController<UIImagePickerControllerDelegate,
    EDStarRatingProtocol>
{}
//IBOutlets
@property(nonatomic, retain) UIImage *photo;
@property (retain, nonatomic) IBOutlet UIButton *photoButton;
@property (retain, nonatomic) IBOutlet UITextField *filenameTxt;
@property (retain, nonatomic) IBOutlet UITextView *fileDescTxtView;
@property (retain, nonatomic) IBOutlet NYSliderPopover *slider_price;
//
@property (retain, nonatomic) IBOutlet UITextField *addressTxt;
@property (retain, nonatomic) IBOutlet UITextField *resturantTxt;
@property (retain, nonatomic) IBOutlet UITextField *telphoneTxt;
@property (retain, getter=isOn) IBOutlet UISwitch *agreeNextTimeSwitch;
//StarRating
@property (strong,nonatomic) NSArray *colors;
@property (retain, nonatomic) IBOutlet
    EDStarRating *starRating;
//IBActions
- (IBAction)uploadPhoto:(id)sender;
- (IBAction)choosePhoto:(id)sender;
- (IBAction)onAddCateItem:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;
@end
