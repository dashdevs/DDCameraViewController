//
//  DDQRViewController.m
//  DDCameraViewController_Example
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDQRViewController.h"
#import "AVCaptureDevice+DDCaptureDeviceModesSwitch.h"
#import "DDCameraViewController+DDCaptureDeviceInputSwitch.h"
#import "DDCameraHints.h"

@interface DDQRViewController ()<DDScannerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *flashModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *torchModeLabel;
@end

@implementation DDQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self updateHints];
}

- (void)setMetadataObjectTypes:(NSArray *)types {
    [super setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
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

#pragma mark - DDCodeScannerViewControllerDelegate

- (void)ddScannerViewController:(DDScannerViewController *)controller didTakeScannedResult:(NSString * _Nullable)resultAsString {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.qrDelegate respondsToSelector:@selector(ddQRViewController:didTakeScannedResult:)]) {
            /*
             Depending on your task you can call stopRunning
             Or dont call stopRunning and dont leave the screen
             Each scan result is unique
             */
            [self.captureSession stopRunning];
            [self.qrDelegate ddQRViewController:self didTakeScannedResult:resultAsString];
        }
    }];
}

@end
