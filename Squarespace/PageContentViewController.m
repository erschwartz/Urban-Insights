
#import "PageContentViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface PageContentViewController ()

@property (weak, nonatomic) IBOutlet UIButton *proceed;

@end

@implementation PageContentViewController

@synthesize description;
@synthesize pageIndex, descriptionText;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.description.text = self.descriptionText;
    if (pageIndex == 2) {
        _proceed.hidden = false;
    } else {
        _proceed.hidden = true;
    }
    
    _proceed.layer.masksToBounds = YES;
    _proceed.layer.cornerRadius = 5;
}

@end
