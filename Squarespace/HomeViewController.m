

#import "HomeViewController.h"
#import "FlickrAPIKey.h"
#import "Flickr.h"
#import "FlickrPhoto.h"
#import "PhotoCollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoDetailViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize applicationTitle, searchBarSelector, helpText, photoCollectionContainer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    photoCollectionContainer.hidden = YES;
    applicationTitle.alpha = 1;
    helpText.alpha = 0;
    [self setNeedsStatusBarAppearanceUpdate];
    searchBarSelector.keyboardAppearance = UIKeyboardAppearanceDark;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidAppear:(BOOL)animated
{
    applicationTitle.alpha = 1;
    helpText.alpha = 0;
    [UIView animateWithDuration:1.5 animations:^{
        applicationTitle.alpha = 0;
    }];
    [UIView animateWithDuration:2.5 animations:^{
        helpText.alpha = 1;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchBarShouldEndEditing: searchBarSelector];
    PhotoCollectionViewController* controller = self.childViewControllers[0];
    photoCollectionContainer.hidden = false;
    controller.searchParameter = searchBarSelector.text;
    controller.currentSearchCount = 21;
    [controller reloadCollectionData];
}

- (BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    return YES;
}

-(BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"didSelectPhotoCollectionViewCell"]) {
        PhotoCollectionViewController* controller = self.childViewControllers[0];
        PhotoCollectionViewCell* cell = (PhotoCollectionViewCell *)sender;
        NSIndexPath* indexPath = [[controller photoCollectionView] indexPathForCell:cell];
        FlickrPhoto* photo = controller.searchResults[controller.searchParameter][indexPath.row];
        UINavigationController* viewController = [segue destinationViewController];
        PhotoDetailViewController* photoDetailViewController = viewController.childViewControllers[0];
        [photoDetailViewController configureWithImage:photo.thumbnail];
        [photoDetailViewController configureWithTitle:photo.title];
    }
}

-(void) dismissKeyboard {
    [searchBarSelector resignFirstResponder];
}

@end
