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

@interface DDQRViewController ()<DDQRCodeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *flashModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *torchModeLabel;
@end

@implementation DDQRViewController

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

#pragma mark - DDQRCodeViewControllerDelegate

- (void)ddQRCodeViewController:(DDQRCodeViewController *)controller didTakeScannedResult:(NSString * _Nullable)string {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.qrDelegate respondsToSelector:@selector(ddQRViewController:didTakeScannedResult:)]) {
            //TODO: - in the future the Scanned Result model will be transmitted
            [self.qrDelegate ddQRViewController:self didTakeScannedResult:string];
        }
    }];
}

@end
