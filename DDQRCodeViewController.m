//
//  DDQRCodeViewController.m
//  DDCameraViewController
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDQRCodeViewController.h"
#import "DDCameraViewController_Private.h"

@interface DDQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic, nullable) NSString *scannedResult;
@property (strong, nonatomic, nullable) NSArray<AVMetadataObjectType> *metadataObjectTypes;
@property (strong, nonatomic, nullable) AVCaptureMetadataOutput *output;
@end

@implementation DDQRCodeViewController

- (void)initializeCaptureSession {
    [super initializeCaptureSession];
    _output = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:_output];
    [_output setMetadataObjectsDelegate:self queue:dd_capture_session_queue()];
    [self setMetadataObjectTypes:nil];
}

- (void)setMetadataObjectTypes:(NSArray<AVMetadataObjectType> * _Nullable)types {
    _metadataObjectTypes = types;
    NSSet *set = [NSSet setWithArray:_metadataObjectTypes];
    NSMutableSet *available = [NSMutableSet setWithArray:[_output availableMetadataObjectTypes]];
    [available intersectSet:set];
    [_output setMetadataObjectTypes:available.allObjects];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    for (AVMetadataObject *current in metadataObjects) {
        if ([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]]
            && [_metadataObjectTypes containsObject:current.type]) {
            NSString *scannedResult = [(AVMetadataMachineReadableCodeObject *)current stringValue];
            if ([self.delegate respondsToSelector:@selector(ddQRCodeViewController:didTakeScannedResult:)]) {
                if (![scannedResult isEqualToString:_scannedResult]) {
                    _scannedResult = scannedResult;
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        [self.delegate ddQRCodeViewController:self didTakeScannedResult:scannedResult];
                    });
                }
            }
            break;
        }
    }
}

@end
