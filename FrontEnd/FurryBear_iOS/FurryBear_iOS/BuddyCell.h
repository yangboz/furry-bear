//
//  BuddyCell.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-24.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuddyCell : UITableViewCell
{}
//IBOutlets
@property (nonatomic, strong) IBOutlet UILabel *userNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *buddyNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong) IBOutlet UIButton *rejectIconBtn;
@property (nonatomic, strong) IBOutlet UIButton *acceptIconBtn;

//IBActions

//Public Properties/Functions
@property(nonatomic,retain) UINavigationController *navigationController;
@end
