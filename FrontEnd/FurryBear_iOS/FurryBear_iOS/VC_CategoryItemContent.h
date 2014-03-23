//
//  VC_CategoryItemContent.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-23.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//@see http://www.appcoda.com/uipageviewcontroller-storyboard-tutorial/

#import <UIKit/UIKit.h>

@interface VC_CategoryItemContent : UIViewController
{}
//IBOutlets
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *desTextView;
//Site properties
@property NSInteger pageIndex;
@property(assign, nonatomic) NSString *titleText;
@property(assign, nonatomic) NSString *descText;
@property(assign, nonatomic) NSString *userImageFile;
//
@end
