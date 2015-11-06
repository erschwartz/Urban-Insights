
#import <QuartzCore/QuartzCore.h>
#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) UIImage *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *photoTitle;
@property (strong, nonatomic) NSString *photoTitleString;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation PhotoDetailViewController

#pragma mark - UIViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    //Sets the correct image/title from the segued image
    self.photoImageView.image = self.photoImage;
    self.photoTitle.text = _photoTitleString;
    
    //Sets the correct corner radius/masks to bounds for rounded button and rounded image
    _photoImageView.layer.cornerRadius = 72;
    _photoImageView.layer.masksToBounds = YES;
    _saveButton.layer.cornerRadius = 5;
    _saveButton.layer.masksToBounds = YES;
    
    //Status bar needs to be set to white
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Configuration Functions

//These methods will set the segued image or segued title accordingly from HomeViewController
- (void)configureWithImage:(UIImage *)paramImage
{
    self.photoImage = paramImage;
}

- (void)configureWithTitle:(NSString *)paramTitle {
    self.photoTitleString = paramTitle;
}

#pragma mark IBAction

//When save is pressed, the image will be saved to the user's photo album and alert the user it has been saved
- (IBAction)didSelectSave:(id)sender {
    UIImageWriteToSavedPhotosAlbum(_photoImage, nil, nil, nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                    message:@"This image has been saved to your camera roll!"
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil,nil];
    [alert show];
}

//This will dismiss the view controller
- (IBAction)didSelectBack:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark Status Bar

//This sets the status bar style to white
+ (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
