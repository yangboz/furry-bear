//
//  FriendCell.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-25.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCell : UITableViewCell
{}
//IBOutlets
@property (nonatomic, strong) IBOutlet UILabel *buddyNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *acceptedOnLabel;
@property (nonatomic, strong) IBOutlet UIButton *blockIconBtn;
@property (nonatomic, strong) IBOutlet UIButton *unblockIconBtn;

//IBActions

//Public Properties/Functions
@property(nonatomic,retain) UINavigationController *navigationController;
@end
