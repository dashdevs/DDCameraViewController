//
//  DDCustomCameraViewController.m
//  DDCameraViewController
//
//  Copyright (c) 2019 dashdevs.com. All rights reserved.
//

#import "DDCustomCameraViewController.h"
#import "AVCaptureDevice+DDCaptureDeviceModesSwitch.h"
#import "DDCameraViewController+DDCaptureDeviceInputSwitch.h"
#import "DDCameraHints.h"

@interface DDCustomCameraViewController ()<DDStillImageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *flashModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *torchModeLabel;

@end

@implementation DDCustomCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self updateHints];
}

- (IBAction)switchCameraButtonTapped:(UIButton*)sender {
    [self switchCaptureDeviceInputWithError:nil];
}

- (IBAction)switchFlashButtonTapped:(UIButton*)sender {
    [self.captureDevice dd_switchFlashMode:nil];
    [self updateHints];
}

- (IBAction)switchTorchButtonTapped:(UIButton*)sender {
    [self.captureDevice dd_switchTorchMode:nil];
    [self updateHints];
}

- (IBAction)takePhotoButtonTapped:(UIButton*)sender {
    [super takePhotoAction:nil];
}

- (void)updateHints {
    self.flashModeLabel.text = DDDeviceFlashModeHintText(self.captureDevice.flashMode);
    self.torchModeLabel.text = DDDeviceTorchModeHintText(self.captureDevice.torchMode);
}

#pragma mark - DDStillImageViewControllerDelegate

- (void)stillImageViewController:(DDStillImageViewController *)controller didFailWithError:(NSError *)error {
    NSLog(@"Failed to take a photo with error: %@", error.localizedDescription);
}

- (void)stillImageViewController:(DDStillImageViewController *)controller didTakePhoto:(UIImage *)photo {
    self.imageView.image = photo;
}

@end
