//
//  DDQRCodeViewController.m
//  DDCameraViewController
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDQRCodeViewController.h"

@interface DDQRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>
@end

@implementation DDQRCodeViewController

- (void)initializeCaptureSession {
    [super initializeCaptureSession];
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:output];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    NSMutableSet *available = [NSMutableSet setWithArray:[output availableMetadataObjectTypes]];
    NSSet *set = [NSSet setWithArray:@[AVMetadataObjectTypeQRCode]];
    [available intersectSet:set];
    [output setMetadataObjectTypes:available.allObjects];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    for (AVMetadataObject *current in metadataObjects) {
        if ([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]]
            && [@[AVMetadataObjectTypeQRCode] containsObject:current.type]) {
            NSString *scannedResult = [(AVMetadataMachineReadableCodeObject *)current stringValue];
            if ([self.delegate respondsToSelector:@selector(ddQRCodeViewController:didTakeScannedResult:)]) {
                //TODO: - it is necessary to add scannedResult parsing and pass the model
                [self.captureSession stopRunning];
                [self.delegate ddQRCodeViewController:self didTakeScannedResult:scannedResult];
            }
            break;
        }
    }
}

@end