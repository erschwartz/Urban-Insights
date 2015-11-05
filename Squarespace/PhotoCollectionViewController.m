

#import "PhotoCollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoDetailViewController.h"
#import "FlickrPhoto.h"
#import "FlickrAPIKey.h"
#import "Flickr.h"

@interface PhotoCollectionViewController ()

@property(nonatomic, strong) Flickr *flickr;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic, strong) NSMutableArray *searches;

@end

@implementation PhotoCollectionViewController

@synthesize photoCollectionView, searches, searchResults, searchParameter, currentSearchCount;

- (void)viewDidLoad
{
    [super viewDidLoad];
    searches = [[NSMutableArray alloc]init];
    searchResults = [[NSMutableDictionary alloc]init];
    self.flickr = [[Flickr alloc] init];
    currentSearchCount = 21;
    [self.photoCollectionView setDelegate:self];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.photoCollectionView addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = NO;
}

- (void) handleTapGesture: (UITapGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint pointPressed = [gestureRecognizer locationInView:self.photoCollectionView];
    NSIndexPath* indexPath = [self.photoCollectionView indexPathForItemAtPoint:pointPressed];
    if (indexPath == nil) {
        NSLog(@"Couldn't find index path for point");
    } else {
        UICollectionViewCell* cell = [self.photoCollectionView cellForItemAtIndexPath:indexPath];
        [[self parentViewController] performSegueWithIdentifier:@"didSelectPhotoCollectionViewCell"  sender:cell];
    }
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.searchResults[searchParameter] count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"photoCollectionViewCell" forIndexPath:indexPath];
    cell.imageView.image = [self.searchResults[searchParameter][indexPath.row] thumbnail];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == currentSearchCount - 22) {
        [self reloadCollectionData];
    }
}

- (void ) reloadCollectionData {
    [self activityIndicator].hidden = NO;
    [self.view bringSubviewToFront:_activityIndicator];
    [self.flickr searchFlickrForTerm: searchParameter size: currentSearchCount completionBlock:^(NSString *searchTerm, NSArray *results, NSError *error) {
        if(results && [results count] > 0) {
            if(![searches containsObject:searchTerm]) {
                [searches insertObject:searchTerm atIndex:0];
                searchResults[searchTerm] = results;
            } else if ([searches containsObject:searchTerm]) {
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
    [self activityIndicator].hidden = YES;
}

@end