

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *description;
@property NSUInteger pageIndex;
@property NSString *descriptionText;

@end
