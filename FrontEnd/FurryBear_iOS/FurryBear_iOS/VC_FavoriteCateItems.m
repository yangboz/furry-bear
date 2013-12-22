//
//  VC_FavoriteCateItems.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-8.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "VC_FavoriteCateItems.h"

@interface VC_FavoriteCateItems ()

@end

@implementation VC_FavoriteCateItems

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // table view data is being set here
    testingData = [[NSMutableArray alloc] init];
//    _favorites = [NSMutableArray arrayWithCapacity:20];
    ItemData *itemData = [[ItemData alloc] init];
    itemData.itemId = @"0";
    itemData.name = @"★";
    itemData.image = @"http://www.google.com";
    itemData.imageName = @"first.png";
    itemData.price = 2;
    [testingData addObject:itemData];
    itemData = [[ItemData alloc] init];
    itemData.itemId = @"1";
    itemData.name = @"☆";
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
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	return [testingData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"FavoriteCell"];
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
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [testingData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
