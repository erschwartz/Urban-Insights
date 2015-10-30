//
//  PhotoCollectionViewController.h
//  Squarespace
//
//  Created by Admin on 10/30/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property(nonatomic, strong) NSMutableDictionary *searchResults;
@property(nonatomic, strong) NSMutableArray *searches;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void) reloadCollectionData;

@end
