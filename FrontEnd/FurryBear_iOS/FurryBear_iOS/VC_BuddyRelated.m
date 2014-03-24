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
    //App42_API_Utils
    buddyService = [[App42_API_Utils sharedInstance] getBuddyService];
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    //1.Get friend request
    NSArray *buddys = [buddyService getFriendRequest:userName];
    NSLog(@"userName is : %@",[[buddys objectAtIndex:0] userName]);
    NSLog(@"buddyName is : %@"  , [[buddys objectAtIndex:0] buddyName]);
    NSLog(@"message is : %@",[[buddys objectAtIndex:0] message]);
    NSLog(@"sendedOn is : %@"  , [[buddys objectAtIndex:0] sendedOn]);
    //fill up the UITableView at first.
    addFriendRequests = [NSMutableArray arrayWithArray:buddys];
    //2.Accept/reject friend request by cell item check.
    
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
	return [addFriendRequests count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	BuddyCell *cell = (BuddyCell *)[tableView
                                        dequeueReusableCellWithIdentifier:@"BuddyCell"];
    NSLog(@"getFriendRequest count:%d",[addFriendRequests count]);
    //Customize cell.
    //cell.contentView.layer.cornerRadius = 4.0f;
    //[cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    //[cell.contentView.layer setBorderWidth:1.0f];
    //
    Buddy *friendRequest = (Buddy *)[addFriendRequests objectAtIndex:indexPath.row];
    cell.userNameLabel.text = friendRequest.userName;
    cell.buddyNameLabel.text = friendRequest.buddyName;
    cell.messageLabel.text =  friendRequest.message;
    //Contray to MVC,temporary transfor the navigationController reference to cell
    cell.navigationController = self.navigationController;
    //IBAction for cell buttons
    //accept
//    [cell.acceptIconBtn addTarget:self action:@selector(acceptIconAction:) forControlEvents:UIControlEventTouchUpInside];
//    cell.acceptIconBtn.tag = indexPath.row;
    //reject
//    [cell.rejectIconBtn addTarget:self action:@selector(rejectIconAction:) forControlEvents:UIControlEventTouchUpInside];

    return cell;

}


#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Section:%d Row:%d selected and its data is %@",
          indexPath.section,indexPath.row,cell.textLabel.text);
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [addFriendRequests removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark -Cell buttons' IBActions
- (void)acceptIconAction:(id)sender
{
    NSString *userName = @"";
    NSString *buddyName = @"John";
    Buddy *buddy = [buddyService acceptFriendRequestFromBuddy:userName toUser:buddyName];
    NSLog(@"userName is :%@",buddy.userName);
    NSLog(@"buddyName is :%@",buddy.buddyName);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSLog(@"sendedOn is :%@",[formatter stringFromDate:buddy.sendedOn]);
    NSLog(@"acceptedOn is :%@",[formatter stringFromDate:buddy.acceptedOn]);
}
- (void)rejectIconAction:(id)sender
{
    NSString *userName = @"Nick";
    NSString *buddyName = @"John";
    Buddy *buddy = [buddyService rejectFriendRequestFromBuddy:userName toUser:buddyName];
    NSLog(@"userName is :%@",buddy.userName);
    NSLog(@"buddyName is :%@",buddy.buddyName);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSLog(@"sendedOn is :%@",[formatter stringFromDate:buddy.sendedOn]);
    NSLog(@"rejectedOn is :%@",[formatter stringFromDate:buddy.acceptedOn]);
}

- (Buddy *)getFriendRequest:(NSInteger)indexPathRow
{
    Buddy *friendRequest = [addFriendRequests objectAtIndex:indexPathRow];
    return friendRequest;
}
@end
