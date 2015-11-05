

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface RootViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic,strong) UIPageViewController *PageViewController;
@property (nonatomic,strong) NSArray *descriptionArray;

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index;

@end
