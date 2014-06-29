//
//  VC_FeedCateItemDetail.m
//  FurryBear_iOS
//
//  Created by yangboz on 14-5-6.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "VC_FeedCateItemDetail.h"

@interface VC_FeedCateItemDetail ()

@end

@implementation VC_FeedCateItemDetail

//Synthesize
@synthesize cateItemData;
@synthesize retractableControllers;

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
    //
    NSLog(@"cateItemData:%@",cateItemData.description);
    NSString *itemId = cateItemData.itemId;
    NSMutableArray *comments =
    [[App42_API_Facade sharedInstance]getReviewsByItem:itemId];
    NSLog(@"cateItemComments:%@",comments.description);
    NSMutableArray *simpleComments = [[NSMutableArray alloc] init];
    for (int i=0; i<[comments count]; i++) {
        [simpleComments addObject:[(Review *)[comments objectAtIndex:i] comment]];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    GCSimpleSectionController* simpleController = [[GCSimpleSectionController alloc] initWithViewController:self];
    //
    GCArraySectionController* arrayController = [[GCArraySectionController alloc]
        initWithArray:simpleComments viewController:self];
    arrayController.title = @"点评:";
//    GCCustomSectionController* customController = [[GCCustomSectionController alloc] initWithViewController:self];
    GCEmptySectionController* emptyController = [[GCEmptySectionController alloc] initWithViewController:self];
    emptyController.title = cateItemData.description;
    self.retractableControllers = [NSArray arrayWithObjects:emptyController, arrayController, nil];
//    [simpleController release];
    [arrayController release];
//    [customController release];
    [emptyController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [cateItemData release];
    retractableControllers = nil;
    //
    [super dealloc];
}

#pragma mark - Table view data source,delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.retractableControllers count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:section];
    return sectionController.numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController cellForRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController didSelectCellAtRow:indexPath.row];
}

@end
