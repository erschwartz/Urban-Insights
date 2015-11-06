//
//  HomeViewControllerTests.m
//  Squarespace
//
//  Created by Admin on 11/6/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HomeViewController.h"
#import <UIKit/UIKit.h>
#import "PhotoCollectionViewController.h"

@interface HomeViewControllerTests : XCTestCase

@property (nonatomic) HomeViewController *homeViewControllerToTest;
@property (nonatomic) PhotoCollectionViewController *photoCollectionViewControllerToTest;

@end

@interface HomeViewController (Test)

@property (weak, nonatomic) IBOutlet UIView *photoCollectionContainer;
- (void) dismissKeyboard;

@end

@implementation HomeViewControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.homeViewControllerToTest = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    self.photoCollectionViewControllerToTest = [storyboard instantiateViewControllerWithIdentifier:@"PhotoCollectionViewController"];
    [_homeViewControllerToTest viewDidLoad];
    [_homeViewControllerToTest loadView];
    [_photoCollectionViewControllerToTest viewDidLoad];
    [_photoCollectionViewControllerToTest loadView];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testViewControllerNotNil {
    XCTAssertNotNil(_homeViewControllerToTest, "HomeViewController was nil");
}

- (void) testSearchBarSearchButtonClicked {
    UISearchBar* searchBar = _homeViewControllerToTest.searchBarSelector;
    searchBar.text = @"Rabbit";
    [_homeViewControllerToTest searchBarSearchButtonClicked:searchBar];
    XCTAssertFalse(_homeViewControllerToTest.photoCollectionContainer.hidden, "SearchBarButton not performing actions as stated");
}

- (void) testDismissKeyboard {
    [_homeViewControllerToTest.searchBarSelector becomeFirstResponder];
    [_homeViewControllerToTest dismissKeyboard];
    XCTAssertFalse(_homeViewControllerToTest.searchBarSelector.isFirstResponder, "Keyboard not beig dismissed properly");
}



@end
