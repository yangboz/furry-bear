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
@property (nonatomic, strong) IBOutlet UIImageView
*ratingImageView;
//IBActions
-(IBAction)reviewAction:(id)sender;
//Public Properties/Functions
@property(nonatomic,retain) UINavigationController *navigationController;

@end
