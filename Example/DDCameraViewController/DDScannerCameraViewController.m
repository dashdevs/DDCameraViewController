//
//  DDScannerCameraViewController.m
//  DDCameraViewController
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDScannerCameraViewController.h"
#import "AVCaptureDevice+DDCaptureDeviceModesSwitch.h"
#import "DDCameraViewController+DDCaptureDeviceInputSwitch.h"
#import "DDCameraHints.h"

@interface DDScannerCameraViewController ()<DDScannerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *flashModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *torchModeLabel;
@end

@implementation DDScannerCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self updateHints];
}

- (void)setMetadataObjectTypes:(NSArray<AVMetadataObjectType> *)types {
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

#pragma mark - DDScannerViewControllerDelegate

- (void)ddScannerViewController:(DDScannerViewController *)controller didTakeScannedResult:(NSString * _Nullable)resultAsString {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.qrDelegate respondsToSelector:@selector(ddScannerCameraViewController:didTakeScannedResult:)]) {
            [self.captureSession stopRunning];
            [self.qrDelegate ddScannerCameraViewController:self didTakeScannedResult:resultAsString];
        }
    }];
}

@end
