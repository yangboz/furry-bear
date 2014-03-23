//
//  VC_CategoryItemMain.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-23.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//@see http://www.appcoda.com/uipageviewcontroller-storyboard-tutorial/
#import <UIKit/UIKit.h>
#import "VC_CategoryItemContent.h"

@interface VC_CategoryItemMain : UIViewController <UIPageViewControllerDataSource>
{}
//PageViewController
@property (strong, nonatomic) UIPageViewController *pageViewController;
//PageProperties
@property(retain,nonatomic) NSArray *pageTitles;
@property(retain,nonatomic) NSArray *pageImages;
@property(retain,nonatomic) NSArray *pageDescriptions;

@end
