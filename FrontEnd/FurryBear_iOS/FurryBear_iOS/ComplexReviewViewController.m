//
//  ComplexReviewViewController.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-10-8.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "ComplexReviewViewController.h"

@interface ComplexReviewViewController ()
#define SEGUE_NAME_IMAGE @"segue_image"
#define SEGUE_NAME_REVIEW @"segue_review"
#define SEGUE_NAME_COMMENT @"segue_comment"
@end

@implementation ComplexReviewViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // table view data is being set here
    testingData = [[NSMutableArray alloc] init];
    //    _favorites = [NSMutableArray arrayWithCapacity:20];
    ItemData *itemData = [[ItemData alloc] init];
    itemData.itemId = @"0";
    itemData.name = @"Default";
    itemData.image = @"http://www.google.com";
    itemData.imageName = @"first.png";
    itemData.price = 2;
    [testingData addObject:itemData];
    itemData = [[ItemData alloc] init];
    itemData.itemId = @"1";
    itemData.name = @"Scallop";
    itemData.image = @"http://www.google.com";
    itemData.imageName = @"Scallop000.jpg";
    itemData.price = 4;
    [testingData addObject:itemData];
    itemData = [[ItemData alloc] init];
    itemData.itemId = @"2";
    itemData.name = @"Hanburge";
    itemData.image = @"http://www.google.com";
    itemData.imageName = @"Hanburge000.jpg";
    itemData.price = 5;
    [testingData addObject:itemData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"ComplexReviewCell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    ItemData *itemData = [testingData objectAtIndex:indexPath.row];
    cell.textLabel.text = itemData.name;
    cell.detailTextLabel.text = itemData.imageName;
    return cell;
}


#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Section:%d Row:%d selected and its data is %@",
          indexPath.section,indexPath.row,cell.textLabel.text);
    //
    NSString *segueName = SEGUE_NAME_IMAGE;
    switch (indexPath.section) {
        case 0:
            segueName = SEGUE_NAME_IMAGE;
            break;
        case 1:
            segueName = SEGUE_NAME_REVIEW;
            break;
        case 2:
            segueName = SEGUE_NAME_COMMENT;
            break;
        default:
            segueName = SEGUE_NAME_IMAGE;
            break;
    }
    [self performSegueWithIdentifier:segueName sender:self];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [testingData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

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

@end