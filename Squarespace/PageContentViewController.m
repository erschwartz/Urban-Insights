//
//  PageContentViewController.m
//  Squarespace
//
//  Created by Admin on 10/29/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "PageContentViewController.h"


@interface PageContentViewController ()

@end

@implementation PageContentViewController

@synthesize description, proceed;
@synthesize pageIndex, descriptionText;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.description.text = self.descriptionText;
    if (pageIndex == 2) {
        proceed.hidden = false;
    } else {
        proceed.hidden = true;
    }
}

@end
