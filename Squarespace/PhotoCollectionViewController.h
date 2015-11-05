
#import <UIKit/UIKit.h>

@interface PhotoCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property(nonatomic, strong) NSString *searchParameter;
@property(nonatomic, assign) int currentSearchCount;
@property(nonatomic, strong) NSMutableDictionary *searchResults;

- (void) reloadCollectionData;

@end
