//
//  FourthViewController.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-20.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>
#import "App42_API_Utils.h"

@interface FourthViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *txt_category;
@property (retain, nonatomic) IBOutlet UITextField *txt_catalogue;
@property (retain, nonatomic) IBOutlet UIButton *btn_category;
@property (retain, nonatomic) IBOutlet UIButton *btn_catalogue;
- (IBAction)on_create_catalogue:(id)sender;
- (IBAction)on_create_category:(id)sender;

@end
