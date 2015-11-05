
#import <UIKit/UIKit.h>


@interface HomeViewController : UIViewController <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UILabel *applicationTitle;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarSelector;
@property (weak, nonatomic) IBOutlet UILabel *helpText;
@property (weak, nonatomic) IBOutlet UIView *photoCollectionContainer;

@end
