
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

- (void) viewDidLoad {
    [super viewDidLoad];
    self.photoImageView.image = self.photoImage;
    self.photoTitle.text = _photoTitleString;
    _photoImageView.layer.cornerRadius = 72;
    _photoImageView.layer.masksToBounds = YES;
    _saveButton.layer.cornerRadius = 5;
    _saveButton.layer.masksToBounds = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

-(void)configureWithImage:(UIImage *)paramImage
{
    self.photoImage = paramImage;
}

- (void)configureWithTitle:(NSString *)paramTitle {
    self.photoTitleString = paramTitle;
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)didSelectSave:(id)sender {
    UIImageWriteToSavedPhotosAlbum(_photoImage, nil, nil, nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                    message:@"This image has been saved to your camera roll!"
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil,nil];
    [alert show];
}
- (IBAction)didSelectBack:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
