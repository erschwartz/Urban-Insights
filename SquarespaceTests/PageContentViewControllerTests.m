//
//  PageContentViewControllerTests.m
//  Squarespace
//
//  Created by Admin on 11/6/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PageContentViewController.h"

@interface PageContentViewControllerTests : XCTestCase

@property (nonatomic) PageContentViewController *pageContentViewControllerToTest;

@end

@interface PageContentViewController (Test)

@property (weak, nonatomic) IBOutlet UIButton *proceed;

@end

@implementation PageContentViewControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.pageContentViewControllerToTest = [storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    [_pageContentViewControllerToTest viewDidLoad];
    [_pageContentViewControllerToTest loadView];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testViewControllerNotNil {
    XCTAssertNotNil(_pageContentViewControllerToTest, "PageContentViewController was nil");
}

- (void)testProceedButtonShowsUpCorrectly {
    [_pageContentViewControllerToTest viewDidLoad];
    _pageContentViewControllerToTest.pageIndex = 2;
    XCTAssertTrue(_pageContentViewControllerToTest.proceed.hidden, "Proceed button is not showing up correctly");
}



@end
