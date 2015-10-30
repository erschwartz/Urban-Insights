//
//  HomeViewController.m
//  Squarespace
//
//  Created by Admin on 10/30/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "HomeViewController.h"
#import "FlickrAPIKey.h"
#import "Flickr.h"
#import "FlickrPhoto.h"
#import "PhotoCollectionViewController.h"

@interface HomeViewController ()

@property(nonatomic, strong) NSMutableDictionary *searchResults;
@property(nonatomic, strong) NSMutableArray *searches;
@property(nonatomic, strong) Flickr *flickr;

@end

@implementation HomeViewController

@synthesize applicationTitle, searchBarSelector, helpText, searchButton, photoCollectionContainer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    photoCollectionContainer.hidden = true;
    applicationTitle.alpha = 1;
    helpText.alpha = 0;
    [self setNeedsStatusBarAppearanceUpdate];
    searchBarSelector.keyboardAppearance = UIKeyboardAppearanceDark;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.searches = [@[] mutableCopy];
    self.searchResults = [@{} mutableCopy];
    self.flickr = [[Flickr alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    applicationTitle.alpha = 1;
    helpText.alpha = 0;
    [UIView animateWithDuration:1.5 animations:^{
        applicationTitle.alpha = 0;
    }];
    [UIView animateWithDuration:2.5 animations:^{
        helpText.alpha = 1;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self didSelectSearch: searchButton];
}

- (BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [self keyboardDidHide];
    [self.view endEditing:YES];
    return YES;
}

-(BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self keyboardDidShow];
    return YES;
}

- (void)keyboardDidShow
{
    CGRect newViewFrame = self.view.frame;
    newViewFrame.size.height -= 225;
    CGRect newHelpFrame = helpText.frame;
    newHelpFrame.size.height -= 225;
    CGRect newButtonFrame = searchButton.frame;
    newButtonFrame.size.height -= 225;
    [UIView animateWithDuration:1.0 animations:^{
        [self.view setFrame:newViewFrame];
        [helpText setFrame:newHelpFrame];
    }];
    [UIView animateWithDuration:0.4 animations:^{
        [searchButton setFrame:newButtonFrame];
    }];

}

-(void)keyboardDidHide
{
    CGRect newFrame = self.view.frame;
    newFrame.size.height += 225;
    CGRect newHelpFrame = helpText.frame;
    newHelpFrame.size.height += 225;
    CGRect newButtonFrame = searchButton.frame;
    newButtonFrame.size.height += 225;
    [UIView animateWithDuration:1.0 animations:^{
        [self.view setFrame:newFrame];
        [helpText setFrame:newHelpFrame];
        [searchButton setFrame:newButtonFrame];
    }];
}

- (IBAction)didSelectSearch:(UIButton *)sender {
    PhotoCollectionViewController* controller = self.childViewControllers[0];
    photoCollectionContainer.hidden = false;
    [controller activityIndicator].hidden = NO;
    [self.flickr searchFlickrForTerm: searchBarSelector.text completionBlock:^(NSString *searchTerm, NSArray *results, NSError *error) {
        if(results && [results count] > 0) {
            NSMutableArray* photosearches = [controller searches];
            NSMutableDictionary* photoSearchResults = [controller searchResults];
            if(![photosearches containsObject:searchTerm]) {
                [photosearches insertObject:searchTerm atIndex:0];
                photoSearchResults[searchTerm] = results; }
            dispatch_async(dispatch_get_main_queue(), ^{                
                [[controller photoCollectionView] reloadData];
                [controller activityIndicator].hidden = YES;
                
            });
        } else {
            NSLog(@"Error searching Flickr: %@", error.localizedDescription);
        } }];
    [searchBarSelector resignFirstResponder];
}

-(void) dismissKeyboard {
    [searchBarSelector resignFirstResponder];
}

@end
