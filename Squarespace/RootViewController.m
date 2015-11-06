

#import "RootViewController.h"

@interface RootViewController ()

@property (nonatomic,strong) NSArray *descriptionArray;

@end

@implementation RootViewController

@synthesize PageViewController, descriptionArray;

# pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Set the strings inside of the description array that will be flashed across the screen
    self.descriptionArray = @[@"find the latest photographs by keyword.",@"filter photographs at your pleasing.",@"explore flickr photographs easily."];
    
    //Instantiating the pageviewcontroller and setting its data source to self
    self.PageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.PageViewController.dataSource = self;
    
    //Setting up the starting view controller by setting the frame, direction, adding it as a subview
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.PageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.PageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    [self addChildViewController:PageViewController];
    [self.view addSubview:PageViewController.view];
    [self.PageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark PageViewController Helper Functions

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    //Ensures that the description array does have contents
    if (([self.descriptionArray count] == 0)) {
        return nil;
    }
    
    //Instantiates the pagecontentviewcontroller, which holds our description label that changes as the user scrolsl
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    
    //Setting the description and page index as the user scrolls
    pageContentViewController.descriptionText = self.descriptionArray[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

//This function will return the new viewcontroller before the current view controller (so if the user scrolls left, it will scroll to this vc)
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

//This function will return the new viewcontroller after the current view controller (so if the user scrolls right, it will scroll to this vc)
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    if (index == NSNotFound)
    {
        return nil;
    }
    index++;
    if (index == [self.descriptionArray count])
    {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

#pragma mark PageViewController Functions

//This is how the pageviewcontroller knows how many view controllers it will be presenting. It is based off of the number of labels we have
-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.descriptionArray count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
