//
//  PageContentViewController.h
//  Squarespace
//
//  Created by Admin on 10/29/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *description;
@property NSUInteger pageIndex;
@property NSString *descriptionText;
@property (weak, nonatomic) IBOutlet UIButton *proceed;

@end
