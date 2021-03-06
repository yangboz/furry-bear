//
//  FeatureCell.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-10-27.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface FeatureCell : UITableViewCell
{
    
}
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *reviewCountLabel;
@property (nonatomic, strong) IBOutlet UILabel *ratingCountLabel;
@property (nonatomic, strong) IBOutlet UILabel *userIdLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeStampLabel;
@property (nonatomic, strong) IBOutlet AsyncImageView
*itemImageView;
//
@property (nonatomic, strong) IBOutlet UIButton *reviewIconBtn;
@property (nonatomic, strong) IBOutlet UIButton *userIconBtn;
@property (nonatomic, strong) IBOutlet UIButton *favIconBtn;
//IBActions

//Public Properties/Functions
@property(nonatomic,retain) UINavigationController *navigationController;

@end
