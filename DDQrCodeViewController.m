//
//  DDQrCodeViewController.m
//  DDCameraViewController
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDQrCodeViewController.h"

@interface DDQrCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic, readonly, nullable) NSArray *metadataObjectTypes;
@end

@implementation DDQrCodeViewController

- (void)initializeCaptureSession {
    [super initializeCaptureSession];
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:output];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    _metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    [output setMetadataObjectTypes:_metadataObjectTypes];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    for (AVMetadataObject *current in metadataObjects) {
        if ([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]]
            && [_metadataObjectTypes containsObject:current.type]) {
            NSString *scannedResult = [(AVMetadataMachineReadableCodeObject *)current stringValue];
            if ([self.delegate respondsToSelector:@selector(qrCodeViewController:didTakeScannedResult:)]) {
                [self.captureSession stopRunning];
                [self.delegate qrCodeViewController:self didTakeScannedResult:scannedResult];
            }
            break;
        }
    }
}

@end
