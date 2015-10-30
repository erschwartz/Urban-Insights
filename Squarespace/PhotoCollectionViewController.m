//
//  PhotoCollectionViewController.m
//  Squarespace
//
//  Created by Admin on 10/30/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "FlickrPhoto.h"

@interface PhotoCollectionViewController ()

@end

@implementation PhotoCollectionViewController

@synthesize photoCollectionView, searches, searchResults;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.photoCollectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photoCollectionViewCell"];
    searches = [[NSMutableArray alloc]init];
    searchResults = [[NSMutableDictionary alloc]init];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    NSString *searchTerm = self.searches[section];
    return [self.searchResults[searchTerm] count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return [self.searches count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"photoCollectionViewCell" forIndexPath:indexPath];
    NSString *searchTerm = self.searches[indexPath.section];
    cell.imageView.image = [self.searchResults[searchTerm][indexPath.row] thumbnail];
    return cell;
}

- (void) reloadCollectionData {
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}

@end