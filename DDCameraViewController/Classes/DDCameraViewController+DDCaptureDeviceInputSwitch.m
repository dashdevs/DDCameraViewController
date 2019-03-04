//
//  DDCameraViewController+DDCaptureDeviceInputSwitch.m
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController+DDCaptureDeviceInputSwitch.h"
#import "DDCameraViewController_Private.h"
#import "AVCaptureDevice+DDCaptureDevicePosition.h"

NS_ASSUME_NONNULL_BEGIN

NS_INLINE NSString * _Nullable DDLocalizedCaptureDeviceInputSwitchErrorDescription(NSInteger code) {
    switch (code) {
        case DDCameraViewControllerErrorNotInitializedCaptureSession:
            return NSLocalizedString(@"Capture session is not initialized.", nil);
        case DDCameraViewControllerErrorNotInitializedCaptureDevice:
            return NSLocalizedString(@"Capture device is not initialized.", nil);
        case DDCameraViewControllerErrorCannotInitializeDeviceInput:
            return NSLocalizedString(@"Failed to initialize a new device input.", nil);
        case DDCameraViewControllerErrorCannotAddDeviceInput:
            return NSLocalizedString(@"Failed to add a new device input.", nil);
        case DDCameraViewControllerErrorNotFoundCaptureDevice:
            return NSLocalizedString(@"Failed to get camera with the requested position.", nil);
        default:
            return nil;
    }
};

@interface NSError (DDCaptureDeviceInputSwitch)

+ (BOOL)noWithErrorCode:(NSInteger)code error:(NSError **)error;

+ (BOOL)noWithUnderlyingError:(NSError *)underlyingError code:(NSInteger)code error:(NSError **)error;

+ (NSError *)cameraViewControllerErrorWithCode:(NSInteger)code;

+ (NSError *)cameraViewControllerErrorWithCode:(NSInteger)code underlyingError:(NSError *)underlyingError;

@end

NS_ASSUME_NONNULL_END

@implementation DDCameraViewController (DDCaptureDeviceInputSwitch)

- (BOOL)switchCaptureDeviceInputWithError:(NSError * _Nullable __autoreleasing *)error {
    AVCaptureSession *session = self.captureSession;
    if (!session) {
        return [NSError noWithErrorCode:DDCameraViewControllerErrorNotInitializedCaptureSession error:error];
    }
    
    AVCaptureDevice *camera = self.captureDevice;
    if (!camera) {
        return [NSError noWithErrorCode:DDCameraViewControllerErrorNotInitializedCaptureDevice error:error];
    }
    
    if (camera.position == AVCaptureDevicePositionBack) {
        camera = [AVCaptureDevice dd_deviceWithMediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
    } else {
        camera = [AVCaptureDevice dd_deviceWithMediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
    }
    if (!camera) {
        return [NSError noWithErrorCode:DDCameraViewControllerErrorNotFoundCaptureDevice error:error];
    }
    
    NSError *inputError = nil;
    AVCaptureDeviceInput *deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:camera error:&inputError];
    if (!deviceInput) {
        return [NSError noWithUnderlyingError:inputError code:DDCameraViewControllerErrorCannotInitializeDeviceInput error:error];
    }
    
    [session beginConfiguration];
    [session removeInput:self.deviceInput];
    if ([session canAddInput:deviceInput]) {
        [session addInput:deviceInput];
        self.captureDevice = camera;
        self.deviceInput = deviceInput;
    } else {
        [session commitConfiguration];
        return [NSError noWithErrorCode:DDCameraViewControllerErrorCannotAddDeviceInput error:error];
    }
    [session commitConfiguration];
    return YES;
}

@end

@implementation NSError (DDCaptureDeviceInputSwitch)

+ (BOOL)noWithErrorCode:(NSInteger)code error:(NSError **)error {
    if (error) {
        *error = [self cameraViewControllerErrorWithCode:code];
    }
    return NO;
}

+ (BOOL)noWithUnderlyingError:(NSError *)underlyingError code:(NSInteger)code error:(NSError **)error {
    if (error) {
        *error = [self cameraViewControllerErrorWithCode:code underlyingError:underlyingError];
    }
    return NO;
}

+ (NSError *)cameraViewControllerErrorWithCode:(NSInteger)code {
    NSString *description = DDLocalizedCaptureDeviceInputSwitchErrorDescription(code);
    NSDictionary *info = nil;
    if (description) {
        info = @{ NSLocalizedDescriptionKey: description };
    }
    return [[NSError alloc] initWithDomain:DDCameraViewControllerErrorDomain code:code userInfo:info];
}

+ (NSError *)cameraViewControllerErrorWithCode:(NSInteger)code underlyingError:(NSError *)underlyingError {
    NSMutableDictionary *info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:underlyingError, NSUnderlyingErrorKey, nil];
    [info setValue:DDLocalizedCaptureDeviceInputSwitchErrorDescription(code) forKey:NSLocalizedDescriptionKey];
    return [[NSError alloc] initWithDomain:DDCameraViewControllerErrorDomain code:code userInfo:info];
}

@end
