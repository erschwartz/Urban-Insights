#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlickrPhoto : NSObject

//These are all of the properties that querying the Flickr API returns
@property(nonatomic,strong) UIImage *thumbnail;
@property(nonatomic,strong) UIImage *largeImage;

@property(nonatomic) long long photoID;
@property(nonatomic) NSInteger farm;
@property(nonatomic) NSInteger server;
@property(nonatomic,strong) NSString *secret;
@property(nonatomic,strong) NSString *title;

@end
