//
//  FourthViewController.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-20.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController
@synthesize txt_catalogue,txt_category;
@synthesize btn_catalogue,btn_category;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [btn_catalogue release];
    [btn_category release];
    [txt_catalogue release];
    [txt_category release];
    [super dealloc];
}
- (IBAction)on_create_catalogue:(id)sender {
    NSLog(@"on_create_catalogue!");
    //
    CatalogueService *cataService = [[App42_API_Utils sharedInstance] getCatalogueService];
    NSString *catalogueName = self.txt_catalogue.text;
    NSString *catalogueDescription = self.txt_catalogue.text;
    Catalogue *catalogue = [cataService createCatalogue:catalogueName catalogueDescription:catalogueDescription]; /* returns the Catalogue object. */
    NSLog(@"catalogueName is = %@",catalogue.name);
    NSLog(@"catalogueDescription is = %@",catalogue.description);
    NSString *jsonResponse = [catalogue toString]; /* returns the response in JSON format. (as shown below)*/
    NSLog(@"CatalogueService_catalogue jsonResponse:%@",jsonResponse);
}

- (IBAction)on_create_category:(id)sender {
    NSLog(@"on_create_category!");
    //
    CatalogueService *cataService = [[App42_API_Utils sharedInstance] getCatalogueService];
    NSString *catalogueName = self.txt_catalogue.text;
    NSString *categoryName = self.txt_category.text;
    NSString *categoryDescription = self.txt_category.text;
    Catalogue *catalogue = [cataService createCategory:catalogueName categoryName:categoryName categoryDescription:categoryDescription]; /* returns the Catalogue object. */
    NSLog(@"categoryName is = %@",catalogue.name);
    NSLog(@"categoryDescription is = %@",catalogue.description);
    NSString *jsonResponse = [catalogue toString]; /* returns the response in JSON format. (as shown below)*/
    NSLog(@"CatalogueService_category jsonResponse:%@",jsonResponse);
}
@end
