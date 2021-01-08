//
//  DDScannerViewController.m
//  DDCameraViewController
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDScannerViewController.h"
#import "DDCameraViewController_Private.h"

static dispatch_queue_t dd_capture_session_queue() {
    static dispatch_queue_t capture_session_queue;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        capture_session_queue = dispatch_queue_create("com.dashdevs.capture.session", DISPATCH_QUEUE_SERIAL);
    });
    return capture_session_queue;
}

@interface DDScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic, nullable) NSArray<AVMetadataObjectType> *scannerMetadataObjectTypes;
@property (strong, nonatomic, nullable) NSString *machineReadableCode;
@property (strong, nonatomic, nullable) AVCaptureMetadataOutput *output;
@end

@implementation DDScannerViewController

- (void)initializeCaptureSession {
    [super initializeCaptureSession];
    _output = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:self.output];
    [self.output setMetadataObjectsDelegate:self queue:dd_capture_session_queue()];
    [self setMetadataObjectTypes:nil];
}

- (void)setMetadataObjectTypes:(NSArray<AVMetadataObjectType> * _Nullable)types {
    self.scannerMetadataObjectTypes = types;
    NSSet *set = [NSSet setWithArray:self.scannerMetadataObjectTypes];
    NSMutableSet *available = [NSMutableSet setWithArray:[self.output availableMetadataObjectTypes]];
    [available intersectSet:set];
    [self.output setMetadataObjectTypes:available.allObjects];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    for (AVMetadataObject *current in metadataObjects) {
        if ([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]]
            && [self.scannerMetadataObjectTypes containsObject:current.type]) {
            NSString *code = [(AVMetadataMachineReadableCodeObject *)current stringValue];
            if ([self.delegate respondsToSelector:@selector(scannerViewController:didScanMachineReadableCode:)]
                && ![code isEqualToString:self.machineReadableCode]) {
                self.machineReadableCode = code;
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [self.delegate scannerViewController:self didScanMachineReadableCode:code];
                });
            }
            break;
        }
    }
}

@end
