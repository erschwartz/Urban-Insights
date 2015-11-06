#import "Flickr.h"
#import "FlickrPhoto.h"


//Defining the supplied API key and API secret that I signed up with from Flickr
#define FLICKR_API_KEY             @"8f6c639bf3067c78f238579c32bb8f3c"
#define FLICKR_API_SHARED_SECRET   @"951305f9f49ed9db"

@implementation Flickr

//This method will return the correct URL I will use to query the Flickr API
+ (NSString *)flickrSearchURLForSearchTerm:(NSString *) searchTerm resultsCalled:(NSInteger *) resultsCalled
{
    searchTerm = [searchTerm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=%ld&format=json&nojsoncallback=1",FLICKR_API_KEY,searchTerm, (long)*resultsCalled];
}

//This method will supply the correct URL for the photo that will be loaded
+ (NSString *)flickrPhotoURLForFlickrPhoto:(FlickrPhoto *) flickrPhoto size:(NSString *) size
{
    if(!size)
    {
        size = @"m";
    }
    return [NSString stringWithFormat:@"http://farm%ld.staticflickr.com/%ld/%lld_%@_%@.jpg",(long)flickrPhoto.farm,(long)flickrPhoto.server,flickrPhoto.photoID,flickrPhoto.secret,size];
}

//This function will search the flickr API for photos based off of the keyword passed
- (void)searchFlickrForTerm:(NSString *) term size:(int) size completionBlock:(FlickrSearchCompletionBlock) completionBlock
{
    //The integer specifies how many images we wish to search for
    NSInteger theInteger = size;
    NSString *searchURL = [Flickr flickrSearchURLForSearchTerm:term resultsCalled:&theInteger];
    
    //We now dispatch this to the priority queue
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSError *error = nil;
        
        //Searching the Flickr API with the search URL we generated
        NSString *searchResultString = [NSString stringWithContentsOfURL:[NSURL URLWithString:searchURL]
                                                                encoding:NSUTF8StringEncoding
                                                                   error:&error];
        //If it completed with an error, do not continue
        if (error != nil) {
            completionBlock(term,nil,error);
        }
        else
        {
            // Otherwise, we will go ahead and parse through the JSON response
            NSData *jsonData = [searchResultString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *searchResultsDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                              options:kNilOptions
                                                                                error:&error];
            
            //If there was an error, do not continue
            if(error != nil)
            {
                completionBlock(term,nil,error);
            }
            else
            {
                
                //If the JSON found that API data parsed had an error (this may be due to typing gibberish, for example)
                NSString * status = searchResultsDict[@"stat"];
                if ([status isEqualToString:@"fail"]) {
                    NSError * error = [[NSError alloc] initWithDomain:@"FlickrSearch" code:0 userInfo:@{NSLocalizedFailureReasonErrorKey: searchResultsDict[@"message"]}];
                    completionBlock(term, nil, error);
                } else {
                    
                    //Creating data structures for our search results
                    NSArray *objPhotos = searchResultsDict[@"photos"][@"photo"];
                    NSMutableArray *flickrPhotos = [@[] mutableCopy];
                    for(NSMutableDictionary *objPhoto in objPhotos)
                    {
                        //Declaring instances of FlicrkPohot and initializing them with the values that we parsed through in the JSON
                        FlickrPhoto *photo = [[FlickrPhoto alloc] init];
                        photo.farm = [objPhoto[@"farm"] intValue];
                        photo.server = [objPhoto[@"server"] intValue];
                        photo.secret = objPhoto[@"secret"];
                        photo.photoID = [objPhoto[@"id"] longLongValue];
                        photo.title = objPhoto[@"title"];
                        
                        //Now loading the image
                        NSString *searchURL = [Flickr flickrPhotoURLForFlickrPhoto:photo size:@"m"];
                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL]
                                                                  options:0
                                                                    error:&error];
                        UIImage *myImage = [UIImage imageWithData:imageData];
                        photo.thumbnail = myImage;
                        [flickrPhotos addObject:photo];
                    }
                    
                    completionBlock(term,flickrPhotos,nil);
                }
            }
        }
    });
}

//This method will load the images for the FlickrPhoto
+ (void)loadImageForPhoto:(FlickrPhoto *)flickrPhoto thumbnail:(BOOL)thumbnail completionBlock:(FlickrPhotoCompletionBlock) completionBlock
{
    
    NSString *size = thumbnail ? @"m" : @"b";
    
    //It will generate the correct PhotoURL for the flickrphoto and the correct size
    NSString *searchURL = [Flickr flickrPhotoURLForFlickrPhoto:flickrPhoto size:size];
    
    //Dispatching this to the priority queue
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSError *error = nil;
        //Starting our request for the photo
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL]
                                                  options:0
                                                    error:&error];
        
        //If there is an error, we do not proceed normally
        if(error)
        {
            completionBlock(nil,error);
        }
        else
        {
            //Otherwise, we load the image as normal, we have two sizes: the thumbnail (which I've used in this application)
            UIImage *image = [UIImage imageWithData:imageData];
            if([size isEqualToString:@"m"])
            {
                flickrPhoto.thumbnail = image;
            }
            //And the large image
            else
            {
                flickrPhoto.largeImage = image;
            }
            completionBlock(image,nil);
        }
        
    });
}



@end
