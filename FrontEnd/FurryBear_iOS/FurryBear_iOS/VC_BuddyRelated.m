//
//  VC_BuddyRelated.m
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-23.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "VC_BuddyRelated.h"

@interface VC_BuddyRelated ()

@end

@implementation VC_BuddyRelated

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //popupAllFriendRequests if neccessary.
    [[PopupManager_AlertTable sharedInstance] popupAllFriendRequests];
    //App42_API_Utils
    buddyService = [[App42_API_Utils sharedInstance] getBuddyService];
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    //GetAllFriends
    allFriends = [[UserModel sharedInstance]  getAllFriends];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	return [allFriends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	FriendCell *cell = (FriendCell *)[tableView
                                        dequeueReusableCellWithIdentifier:@"FriendCell"];
    NSLog(@"allFriends count:%d",[allFriends count]);
    //Customize cell.
    //cell.contentView.layer.cornerRadius = 4.0f;
    //[cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    //[cell.contentView.layer setBorderWidth:1.0f];
    //
    selectedFriend = (Buddy *)[allFriends objectAtIndex:indexPath.row];
    cell.buddyNameLabel.text = selectedFriend.buddyName;
    //
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    cell.acceptedOnLabel.text = [formatter stringFromDate:selectedFriend.acceptedOn];
    //Contray to MVC,temporary transfor the navigationController reference to cell
    cell.navigationController = self.navigationController;
    //IBAction for cell buttons
    //block
    [cell.blockIconBtn addTarget:self action:@selector(blockIconAction:) forControlEvents:UIControlEventTouchUpInside];
    //unblock
    [cell.blockIconBtn addTarget:self action:@selector(unblockIconAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;

}


#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Section:%d Row:%d selected and its data is %@",
          indexPath.section,indexPath.row,cell.textLabel.text);
    //Popup FriendTalk
    [[PopupManager_DTAlertView sharedInstance] popupFriendTalk];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [allFriends removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark -Cell buttons' IBActions
- (void)acceptIconAction:(id)sender
{
    //
    NSString *buddyName = selectedFriend.buddyName;
    Buddy *buddy = [buddyService acceptFriendRequestFromBuddy:buddyName toUser:buddyName];
    NSLog(@"userName is :%@",buddy.userName);
    NSLog(@"buddyName is :%@",buddy.buddyName);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSLog(@"sendedOn is :%@",[formatter stringFromDate:buddy.sendedOn]);
    NSLog(@"acceptedOn is :%@",[formatter stringFromDate:buddy.acceptedOn]);
}
- (void)rejectIconAction:(id)sender
{
    //
    NSString *userName = selectedFriend.userName;
    NSString *buddyName = selectedFriend.buddyName;
    //
    Buddy *buddy = [buddyService rejectFriendRequestFromBuddy:userName toUser:buddyName];
    NSLog(@"userName is :%@",buddy.userName);
    NSLog(@"buddyName is :%@",buddy.buddyName);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSLog(@"sendedOn is :%@",[formatter stringFromDate:buddy.sendedOn]);
    NSLog(@"rejectedOn is :%@",[formatter stringFromDate:buddy.acceptedOn]);
}
- (void)blockIconAction:(id)sender
{
    //
    NSString *userName = selectedFriend.userName;
    NSString *buddyName = selectedFriend.buddyName;
    //
    Buddy *buddy = [buddyService blockBuddy:buddyName byUser:userName];
    NSLog(@"userName is :%@",buddy.userName);
    NSLog(@"buddyName is :%@",buddy.buddyName);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSLog(@"sendedOn is :%@",[formatter stringFromDate:buddy.sendedOn]);
    NSLog(@"rejectedOn is :%@",[formatter stringFromDate:buddy.acceptedOn]);
}
- (void)unblockIconAction:(id)sender
{
    //
    NSString *userName = selectedFriend.userName;
    NSString *buddyName = selectedFriend.buddyName;
    //
    Buddy *buddy = [buddyService unblockBuddy:buddyName byUser:userName];
    NSLog(@"userName is :%@",buddy.userName);
    NSLog(@"buddyName is :%@",buddy.buddyName);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSLog(@"sendedOn is :%@",[formatter stringFromDate:buddy.sendedOn]);
    NSLog(@"rejectedOn is :%@",[formatter stringFromDate:buddy.acceptedOn]);
}
@end
