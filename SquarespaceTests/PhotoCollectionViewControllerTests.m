//
//  PhotoCollectionViewControllerTests.m
//  Squarespace
//
//  Created by Admin on 11/6/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PhotoCollectionViewController.h"
#import "HomeViewController.h"
#import "FlickrPhoto.h"

@interface PhotoCollectionViewControllerTests : XCTestCase

@property (nonatomic) HomeViewController *homeViewControllerToTest;
@property (nonatomic) PhotoCollectionViewController *photoCollectionViewControllerToTest;

@end

@implementation PhotoCollectionViewControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.photoCollectionViewControllerToTest = [storyboard instantiateViewControllerWithIdentifier:@"PhotoCollectionViewController"];
    [_photoCollectionViewControllerToTest viewDidLoad];
    [_photoCollectionViewControllerToTest loadView];
    self.homeViewControllerToTest = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [_homeViewControllerToTest viewDidLoad];
    [_homeViewControllerToTest loadView];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testViewControllerNotNil {
    XCTAssertNotNil(_photoCollectionViewControllerToTest, "PhotoContentViewController was nil");
}

- (void)testViewDidLoadInitializesCorrectly {
    [_photoCollectionViewControllerToTest viewDidLoad];
    XCTAssertEqual(21, _photoCollectionViewControllerToTest.currentSearchCount, "Values not initialized correctly");
}

- (void)testCollectionViewNumberOfSections {
    XCTAssertEqual(1, [_photoCollectionViewControllerToTest photoCollectionView].numberOfSections, "Number of sections not set correctly");
}


@end
