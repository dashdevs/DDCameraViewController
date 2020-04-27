//
//  DDQrViewController.m
//  DDCameraViewController_Example
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDQrViewController.h"
#import "AVCaptureDevice+DDCaptureDeviceModesSwitch.h"
#import "DDCameraViewController+DDCaptureDeviceInputSwitch.h"

NS_INLINE NSString* DDDeviceFlashModeHintText(AVCaptureFlashMode mode) {
    switch (mode) {
        case AVCaptureFlashModeOff: return NSLocalizedString(@"Flash off", nil);
        case AVCaptureFlashModeOn: return NSLocalizedString(@"Flash on", nil);
        case AVCaptureFlashModeAuto: return NSLocalizedString(@"Flash auto", nil);
        default: return NSLocalizedString(@"Flash not found", nil);
    }
};

NS_INLINE NSString* DDDeviceTorchModeHintText(AVCaptureTorchMode mode) {
    switch (mode) {
        case AVCaptureTorchModeOff: return NSLocalizedString(@"Torch off", nil);
        case AVCaptureTorchModeOn: return NSLocalizedString(@"Torch on", nil);
        case AVCaptureTorchModeAuto: return NSLocalizedString(@"Torch auto", nil);
        default: return NSLocalizedString(@"Torch not found", nil);
    }
};

@interface DDQrViewController ()<DDQrCodeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *flashModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *torchModeLabel;
@end

@implementation DDQrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self updateHints];
}

- (IBAction)cancelButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
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

- (void)updateHints {
    self.flashModeLabel.text = DDDeviceFlashModeHintText(self.captureDevice.flashMode);
    self.torchModeLabel.text = DDDeviceTorchModeHintText(self.captureDevice.torchMode);
}

#pragma mark - DDQrCodeViewControllerDelegate

- (void)qrCodeViewController:(DDQrCodeViewController *)controller didFailWithError:(NSError *)error {
    NSLog(@"Failed to take a photo with error: %@", error.localizedDescription);
}

- (void)qrCodeViewController:(DDQrCodeViewController *)controller didTakeScannedResult:(NSString *)string {
    NSLog(@"Your Scann Result %@", string);
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
