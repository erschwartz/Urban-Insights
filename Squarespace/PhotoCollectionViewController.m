

#import "PhotoCollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoDetailViewController.h"
#import "FlickrPhoto.h"
#import "Flickr.h"

@interface PhotoCollectionViewController ()

//Flickr is the class that will handle any searches
@property(nonatomic, strong) Flickr *flickr;
@property(nonatomic, strong) NSMutableArray *searches;

@end

@implementation PhotoCollectionViewController

@synthesize photoCollectionView, searchResults, searchParameter, currentSearchCount;

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initializing
    _searches = [[NSMutableArray alloc]init];
    searchResults = [[NSMutableDictionary alloc]init];
    self.flickr = [[Flickr alloc] init];
    currentSearchCount = 21;
    
    //Setting delegate
    [self.photoCollectionView setDelegate:self];
    
    //Adding tap gesture for collection view as didselect was only working for long taps
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.photoCollectionView addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = NO;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Tap Gesture

- (void) handleTapGesture: (UITapGestureRecognizer *)gestureRecognizer {
    //First check if that gesture has ended yet, if it hasn't, return
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    //From the point pressed in the collection view, use this to generate the indexpath, and then use the respective cell as our segue sender (from the parent view controller, which is HomeViewController)
    CGPoint pointPressed = [gestureRecognizer locationInView:self.photoCollectionView];
    NSIndexPath* indexPath = [self.photoCollectionView indexPathForItemAtPoint:pointPressed];
    if (indexPath == nil) {
        NSLog(@"Couldn't find index path for point");
    } else {
        UICollectionViewCell* cell = [self.photoCollectionView cellForItemAtIndexPath:indexPath];
        [[self parentViewController] performSegueWithIdentifier:@"didSelectPhotoCollectionViewCell"  sender:cell];
    }
}

#pragma mark UICollectionView

//Number of items depends on the current search parameter (which is set via HomeViewController)
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.searchResults[searchParameter] count];
}

//Number of sections is always 1
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

//Setting the cell to the custom class PhotoCollectionViewCell and setting its image
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"photoCollectionViewCell" forIndexPath:indexPath];
    cell.imageView.image = [self.searchResults[searchParameter][indexPath.row] thumbnail];
    return cell;
}

//This function tells the collectionview when to load more photos. When scrolled to the bottom of the collectionview, this function will then call reloadcollectiondata.
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == currentSearchCount - 22) {
        [self reloadCollectionData];
    }
}

#pragma mark Reload function

//The current search count (which is pre-incremented), tells Flickr how many results to search for. These are then added to search results and the collectionview is reloaded to show more photos
- (void ) reloadCollectionData {
    [self.flickr searchFlickrForTerm: searchParameter size: currentSearchCount completionBlock:^(NSString *searchTerm, NSArray *results, NSError *error) {
        if(results && [results count] > 0) {
            if(![_searches containsObject:searchTerm]) {
                [_searches insertObject:searchTerm atIndex:0];
                searchResults[searchTerm] = results;
            } else if ([_searches containsObject:searchTerm]) {
                searchResults[searchTerm] = results;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.currentSearchCount += 21;
                [photoCollectionView reloadData];
            });
        } else {
            NSLog(@"Error searching Flickr: %@", error.localizedDescription);
        }
    }];
}



@end