

#import "HomeViewController.h"
#import "Flickr.h"
#import "FlickrPhoto.h"
#import "PhotoCollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoDetailViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *helpText;
@property (weak, nonatomic) IBOutlet UIView *photoCollectionContainer;
@property (weak, nonatomic) IBOutlet UILabel *applicationTitle;

@end

@implementation HomeViewController

@synthesize searchBarSelector;

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //The status bar needs to change to white
    searchBarSelector.keyboardAppearance = UIKeyboardAppearanceDark;
    [self setNeedsStatusBarAppearanceUpdate];
    
    //Setting the initial alpha/hidden values. The photocollectioncontainer is originally hidden because it does not appear until the user searchs.
    _photoCollectionContainer.hidden = YES;
    _applicationTitle.alpha = 1;
    _helpText.alpha = 0;
    
    //Adding a tap gesture so that when the user clicks outside of the keyboard, it will dismiss the keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark StatusBar

//Setting the status bar style to light, as we have a black background
+ (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark Keyboard Helper Dismiss

//This will dismiss the keyboard when the tap gesture is activated
- (void) dismissKeyboard {
    [searchBarSelector resignFirstResponder];
}

#pragma mark Search Bar Methods

//When the search bar button is clicked, the container view, which is the photocollectionviewcontroller, will then search for new results and reload its data.
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchBarShouldEndEditing: searchBarSelector];
    PhotoCollectionViewController* controller = self.childViewControllers[0];
    _photoCollectionContainer.hidden = false;
    controller.searchParameter = searchBarSelector.text;
    controller.currentSearchCount = 21;
    [controller reloadCollectionData];
}

//After it is done editing, the keyboard will disappear
- (BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    return YES;
}

#pragma mark Segue Methods


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //First checking that the identifier is correct (otherwise the container view might use this)
    if ([segue.identifier  isEqual: @"didSelectPhotoCollectionViewCell"]) {
        
        //Getting the photocollectionviewcontroller and the photocollectionviewcell which will aid use in segueing
        PhotoCollectionViewController* controller = self.childViewControllers[0];
        PhotoCollectionViewCell* cell = (PhotoCollectionViewCell *)sender;
        
        //Getting the correct index path in order to get the correct photo. This photo will then be used to display contents on the photodetailviewcontroller.
        NSIndexPath* indexPath = [[controller photoCollectionView] indexPathForCell:cell];
        FlickrPhoto* photo = controller.searchResults[controller.searchParameter][indexPath.row];
        
        //We are originally segueing to a navigationviewcontroller, so we need to grab its first child
        UINavigationController* viewController = [segue destinationViewController];
        PhotoDetailViewController* photoDetailViewController = viewController.childViewControllers[0];
        
        //Configuring the photodetailviewcontroller with the correct thumbnail and title
        [photoDetailViewController configureWithImage:photo.thumbnail];
        [photoDetailViewController configureWithTitle:photo.title];
    }
}


@end
