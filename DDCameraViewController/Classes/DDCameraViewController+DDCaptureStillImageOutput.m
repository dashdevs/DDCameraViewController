//
//  DDCameraViewController+DDCaptureStillImageOutput.m
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController+DDCaptureStillImageOutput.h"

@implementation DDCameraViewController (DDCaptureStillImageOutput)

#pragma mark - public methods

- (AVCaptureStillImageOutput *)addStillImageOutputWithVideoCodec:(NSString *)codec {
    AVCaptureStillImageOutput *output = [[AVCaptureStillImageOutput alloc] init];
    output.outputSettings = @{ AVVideoCodecKey: codec };
    
    AVCaptureSession *session = self.captureSession;
    if ([session canAddOutput:output]) {
        [session addOutput:output];
        return output;
    }
    return nil;
}

- (void)removeStillImageOutput:(AVCaptureStillImageOutput *)output {
    AVCaptureSession *session = self.captureSession;
    if (session) {
        [session removeOutput:output];
    }
}

@end
