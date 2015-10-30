//
//  HomeViewController.h
//  Squarespace
//
//  Created by Admin on 10/30/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ObjectiveFlickr/ObjectiveFlickr.h>


@interface HomeViewController : UIViewController <UISearchBarDelegate, OFFlickrAPIRequestDelegate>

@property (weak, nonatomic) IBOutlet UILabel *applicationTitle;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarSelector;
@property (weak, nonatomic) IBOutlet UILabel *helpText;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIView *photoCollectionContainer;

-(BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar;
-(BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar;
-(void)keyboardDidShow;
-(void)keyboardDidHide;
- (IBAction)didSelectSearch:(UIButton *)sender;


@end
