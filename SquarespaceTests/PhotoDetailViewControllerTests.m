//
//  PhotoDetailViewControllerTests.m
//  Squarespace
//
//  Created by Admin on 11/6/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PhotoDetailViewController.h"

@interface PhotoDetailViewControllerTests : XCTestCase

@property (nonatomic) PhotoDetailViewController *photoDetailViewControllerToTest;

@end


@interface PhotoDetailViewController (Test)

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) UIImage *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *photoTitle;
@property (strong, nonatomic) NSString *photoTitleString;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation PhotoDetailViewControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.photoDetailViewControllerToTest = [storyboard instantiateViewControllerWithIdentifier:@"PhotoDetailViewController"];
    [_photoDetailViewControllerToTest viewDidLoad];
    [_photoDetailViewControllerToTest loadView];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testViewControllerNotNil {
    XCTAssertNotNil(_photoDetailViewControllerToTest, "PhotoDetailViewController was nil");
}

- (void)testViewLoadedCorrectly {
     _photoDetailViewControllerToTest.photoImage = [UIImage imageNamed:@"oceanStartup"];
    [_photoDetailViewControllerToTest viewDidLoad];
    XCTAssertNotNil(_photoDetailViewControllerToTest.photoImageView.image, "Image was not set correctly");
}

- (void)testConfigureImage {
    [_photoDetailViewControllerToTest viewDidLoad];
    UIImage* img = [UIImage imageNamed:@"oceanStartup"];
    [_photoDetailViewControllerToTest configureWithImage:img];
    XCTAssertNotNil(_photoDetailViewControllerToTest.photoImage, "Photo image not set correctly");
}

- (void)testConfigureTtile {
    [_photoDetailViewControllerToTest viewDidLoad];
    NSString* aString = @"Hello";
    [_photoDetailViewControllerToTest configureWithTitle:aString];
    XCTAssertNotNil(_photoDetailViewControllerToTest.photoTitleString, "Photo image not set correctly");
}


@end
