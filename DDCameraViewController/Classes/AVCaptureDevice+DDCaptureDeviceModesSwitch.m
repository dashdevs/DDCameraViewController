//
//  AVCaptureDevice+DDCaptureDeviceModesSwitch.m
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "AVCaptureDevice+DDCaptureDeviceModesSwitch.h"

NSString *const DDCaptureDeviceErrorDomain = @"DDCaptureDeviceErrorDomain";

NS_INLINE AVCaptureFlashMode DDCaptureDeviceNextFlashMode(AVCaptureFlashMode mode) {
    switch (mode) {
        case AVCaptureFlashModeOff: return AVCaptureFlashModeOn;
        case AVCaptureFlashModeOn: return AVCaptureFlashModeAuto;
        case AVCaptureFlashModeAuto: return AVCaptureFlashModeOff;
    }
};

NS_INLINE AVCaptureTorchMode DDCaptureDeviceNextTorchMode(AVCaptureTorchMode mode) {
    switch (mode) {
        case AVCaptureTorchModeOff: return AVCaptureTorchModeOn;
        case AVCaptureTorchModeOn: return AVCaptureTorchModeAuto;
        case AVCaptureTorchModeAuto: return AVCaptureTorchModeOff;
    }
};

@implementation AVCaptureDevice (DDCaptureDeviceModesSwitch)

- (BOOL)dd_switchFlashMode:(NSError * _Nullable __autoreleasing *)error {
    if (self.hasFlash) {
        NSError *lockError = nil;
        if ([self lockForConfiguration:&lockError]) {
            self.flashMode = DDCaptureDeviceNextFlashMode(self.flashMode);
            [self unlockForConfiguration];
        } else {
            *error = [NSError errorWithDomain:DDCaptureDeviceErrorDomain code:DDCaptureDeviceLockError userInfo:@{ NSUnderlyingErrorKey: lockError }];
            return NO;
        }
    } else {
        *error = [NSError errorWithDomain:DDCaptureDeviceErrorDomain code:DDCaptureDeviceModesErrorNoFlash userInfo:nil];
        return NO;
    }
    return YES;
}

- (BOOL)dd_switchTorchMode:(NSError * _Nullable __autoreleasing *)error {
    if (self.hasTorch) {
        NSError *lockError = nil;
        if ([self lockForConfiguration:&lockError]) {
            self.torchMode = DDCaptureDeviceNextTorchMode(self.torchMode);
            [self unlockForConfiguration];
        } else {
            *error = [NSError errorWithDomain:DDCaptureDeviceErrorDomain code:DDCaptureDeviceLockError userInfo:@{ NSUnderlyingErrorKey: lockError }];
            return NO;
        }
    } else {
        *error = [NSError errorWithDomain:DDCaptureDeviceErrorDomain code:DDCaptureDeviceModesErrorNoTorch userInfo:nil];
        return NO;
    }
    return YES;
}

@end
