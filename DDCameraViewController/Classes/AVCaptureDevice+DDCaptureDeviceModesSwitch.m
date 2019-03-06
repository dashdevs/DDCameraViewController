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

@interface NSError (DDCaptureDeviceModesSwitch)

+ (BOOL)noWithCaptureDeviceErrorCode:(NSInteger)code underlyingError:(NSError*)error error:(NSError**)error;
+ (BOOL)noWithCaptureDeviceErrorCode:(NSInteger)code error:(NSError**)error;

@end

@implementation AVCaptureDevice (DDCaptureDeviceModesSwitch)

- (BOOL)dd_switchFlashMode:(NSError * _Nullable __autoreleasing *)error {
    if (self.hasFlash) {
        NSError *lockError = nil;
        if ([self lockForConfiguration:&lockError]) {
            self.flashMode = DDCaptureDeviceNextFlashMode(self.flashMode);
            [self unlockForConfiguration];
        } else {
            return [NSError noWithCaptureDeviceErrorCode:DDCaptureDeviceLockError underlyingError:lockError error:error];
        }
    } else {
        return [NSError noWithCaptureDeviceErrorCode:DDCaptureDeviceModesErrorNoFlash error:error];
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
            return [NSError noWithCaptureDeviceErrorCode:DDCaptureDeviceLockError underlyingError:lockError error:error];
        }
    } else {
        return [NSError noWithCaptureDeviceErrorCode:DDCaptureDeviceModesErrorNoTorch error:error];
    }
    return YES;
}

@end

@implementation NSError (DDCaptureDeviceModesSwitch)

+ (BOOL)noWithCaptureDeviceErrorCode:(NSInteger)code error:(NSError *__autoreleasing *)error {
    if (error) {
        *error = [NSError errorWithDomain:DDCaptureDeviceErrorDomain code:code userInfo:nil];
    }
    return NO;
}

+ (BOOL)noWithCaptureDeviceErrorCode:(NSInteger)code underlyingError:(NSError *)underlyingError error:(NSError *__autoreleasing *)error {
    if (error) {
        *error = [NSError errorWithDomain:DDCaptureDeviceErrorDomain code:code userInfo:@{ NSUnderlyingErrorKey: underlyingError }];
    }
    return NO;
}

@end
