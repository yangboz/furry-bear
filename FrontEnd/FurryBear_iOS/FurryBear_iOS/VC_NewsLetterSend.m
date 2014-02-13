//
//  VC_NewsLetterSend.m
//  FurryBear_iOS
//
//  Created by yangboz on 14-2-10.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "VC_NewsLetterSend.h"

@interface VC_NewsLetterSend ()

@end

@implementation VC_NewsLetterSend

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    return cell;
}
*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - IBOutlet
-(void)on_send_newsletter:(id)sender;
{
    EmailService *emailService = [[App42_API_Utils sharedInstance] getEmailService];
    @try{
        //App42 service API call here.
        Email *email = [emailService sendMail:self.txt_sendTo.text subject:self.txt_sendSubject.text Message:self.txt_sendMsg.text fromEmail:self.txt_sendFrom.text emailMIME:[self getTextMimeType]];/* returns the Email object. */
        NSString *jsonResponse = [email toString]; /* returns the response in JSON format. (as shown below)*/
        NSLog(@"EmailService json response:%@",jsonResponse);
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
        //NSAlert here.
    }
    
    
}

//Private
-(NSString *)getTextMimeType;
{
    NSString *textMimeType = PLAIN_TEXT_MIME_TYPE;
    if (self.textMimeTypeSegmentedCtr.selectedSegmentIndex==0) {
        textMimeType = HTML_TEXT_MIME_TYPE;
    }
    return textMimeType;
}

@end
