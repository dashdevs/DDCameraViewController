//
//  DDViewController.m
//  DDCameraViewController
//
//  Copyright (c) 2019 dashdevs.com. All rights reserved.
//

#import "DDViewController.h"
#import "AVCaptureDevice+DDCaptureDeviceModesSwitch.h"
#import "DDCameraViewController+DDCaptureDeviceInputSwitch.h"

@interface DDViewController ()<DDStillImageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (IBAction)switchCameraButtonTapped:(UIButton*)sender {
    [self switchCaptureDeviceInputWithError:nil];
}

- (IBAction)switchFlashButtonTapped:(UIButton*)sender {
    [self.captureDevice dd_switchFlashMode:nil];
}

- (IBAction)switchTorchButtonTapped:(UIButton*)sender {
    [self.captureDevice dd_switchTorchMode:nil];
}

- (IBAction)takePhotoButtonTapped:(UIButton*)sender {
    [super takePhotoAction:nil];
}

#pragma mark - DDStillImageViewControllerDelegate

- (void)stillImageViewController:(DDStillImageViewController *)controller didFailWithError:(NSError *)error {
    NSLog(@"Failed to take a photo with error: %@", error.localizedDescription);
}

- (void)stillImageViewController:(DDStillImageViewController *)controller didTakePhoto:(UIImage *)photo {
    self.imageView.image = photo;
}

@end
