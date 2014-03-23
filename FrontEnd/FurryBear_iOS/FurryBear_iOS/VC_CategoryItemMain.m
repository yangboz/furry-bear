//
//  VC_CategoryItemMain.m
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-23.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "VC_CategoryItemMain.h"

@interface VC_CategoryItemMain ()

@end

@implementation VC_CategoryItemMain

@synthesize pageDescriptions,pageImages,pageTitles;

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
    // Create the data model
    self.pageTitles = [[NSArray alloc] initWithObjects:@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip", @"Free Regular Update",nil];
    self.pageImages = [[NSArray alloc] initWithObjects:@"page1.png", @"page2.png", @"page3.png", @"page4.png",nil];
    self.pageDescriptions = [[NSArray alloc] initWithObjects:@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip", @"Free Regular Update",nil];
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    //
    VC_CategoryItemContent *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
    //
    [self.pageDescriptions release];
    [self.pageImages release];
    [self.pageTitles release];
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
#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((VC_CategoryItemContent*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((VC_CategoryItemContent*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
//Helper function
- (VC_CategoryItemContent *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    VC_CategoryItemContent *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VC_CategoryItemContent"];
    pageContentViewController.userImageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.descText = self.pageDescriptions[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}
//
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
@end
