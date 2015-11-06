//
//  AppDelegateTests.m
//  Squarespace
//
//  Created by Admin on 11/6/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface AppDelegateTests : XCTestCase

@property (nonatomic) AppDelegate *appDelegateToTest;

@end

@implementation AppDelegateTests

- (void)setUp {
    [super setUp];
    AppDelegate* delegate = UIApplication.sharedApplication.delegate;
    _appDelegateToTest = delegate;
}

- (void)testAppDelegateNotNil {
    XCTAssertNotNil(_appDelegateToTest, "AppDelegate was nil");
}

- (void)tearDown {
    [super tearDown];
}


@end
