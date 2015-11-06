
#import "PageContentViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface PageContentViewController ()

@property (weak, nonatomic) IBOutlet UIButton *proceed;
@property (weak, nonatomic) IBOutlet UILabel *description;

@end

@implementation PageContentViewController

@synthesize description;
@synthesize pageIndex, descriptionText;

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setting the correct description based off of the passed descriptiontext
    self.description.text = self.descriptionText;
    
    //If we are on the last page in the pageviewcontroller, calculated as 2, we will unhide the proceed button
    if (pageIndex == 2) {
        _proceed.hidden = false;
    } else {
        _proceed.hidden = true;
    }
    
    //Using quartzcore in order to round the edges of the rectangular proceed button
    _proceed.layer.masksToBounds = YES;
    _proceed.layer.cornerRadius = 5;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
