//
//  RootViewControllerTests.m
//  Squarespace
//
//  Created by Admin on 11/6/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RootViewController.h"

@interface RootViewControllerTests : XCTestCase

@property (nonatomic) RootViewController *rootViewControllerToTest;

@end

@interface RootViewController (Test)

@property (nonatomic,strong) NSArray *descriptionArray;

@end

@implementation RootViewControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.rootViewControllerToTest = [storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
    [_rootViewControllerToTest viewDidLoad];
    [_rootViewControllerToTest loadView];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testViewControllerNotNil {
    XCTAssertNotNil(_rootViewControllerToTest, "RootViewController was nil");
}

- (void)testViewDidLoadSetUpCorrectly {
    [_rootViewControllerToTest viewDidLoad];
    XCTAssertEqual(3, _rootViewControllerToTest.descriptionArray.count, "View did load did not set up correctly");
}

@end
