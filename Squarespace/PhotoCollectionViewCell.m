//
//  PhotoCollectionViewCell.m
//  Squarespace
//
//  Created by Admin on 10/30/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@interface PhotoCollectionViewCell ()

@end

@implementation PhotoCollectionViewCell

@synthesize photo, imageView;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height /2;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 0;
    
}

@end

