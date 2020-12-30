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
    [super setMetadataObjectTypes:@[AVMetadataObjectTypeUPCECode,
                                    AVMetadataObjectTypeCode39Code,
                                    AVMetadataObjectTypeCode39Mod43Code,
                                    AVMetadataObjectTypeEAN13Code,
                                    AVMetadataObjectTypeEAN8Code,
                                    AVMetadataObjectTypeCode93Code,
                                    AVMetadataObjectTypeCode128Code,
                                    AVMetadataObjectTypePDF417Code,
                                    AVMetadataObjectTypeQRCode,
                                    AVMetadataObjectTypeAztecCode,
                                    AVMetadataObjectTypeInterleaved2of5Code,
                                    AVMetadataObjectTypeITF14Code,
                                    AVMetadataObjectTypeDataMatrixCode]];
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

- (void)scannerViewController:(DDScannerViewController *)controller didScanMachineReadableCode:(NSString * _Nullable)code {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.scannerDelegate respondsToSelector:@selector(scannerCameraViewController:didScanMachineReadableCode:)]) {
            [self.captureSession stopRunning];
            [self.scannerDelegate scannerCameraViewController:self didScanMachineReadableCode:code];
        }
    }];
}

@end
