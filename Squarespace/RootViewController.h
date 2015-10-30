//
//  RootViewController.h
//  Squarespace
//
//  Created by Admin on 10/29/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface RootViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic,strong) UIPageViewController *PageViewController;
@property (nonatomic,strong) NSArray *descriptionArray;

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index;

@end
