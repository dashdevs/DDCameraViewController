//
//  DDCameraViewController+DDCaptureDeviceInputSwitch.h
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 This enum describes codes for errors that may arrise while creating or changing current device capture hardware (back, front camera, etc)

 - DDCameraViewControllerErrorNotInitializedCaptureSession: Capture session was not initialised
 - DDCameraViewControllerErrorNotInitializedCaptureDevice: Device hardware was not initialised
 - DDCameraViewControllerErrorCannotInitializeDeviceInput: Сapture input, that provides media from a capture device to a capture session, was not initialised
 - DDCameraViewControllerErrorCannotAddDeviceInput: Error occured while adding device input to capture session
 - DDCameraViewControllerErrorNotFoundCaptureDevice: Capture hardware is not found on current device
 */
NS_ENUM (NSInteger) {
    DDCameraViewControllerErrorNotInitializedCaptureSession = -80000,
    DDCameraViewControllerErrorNotInitializedCaptureDevice = -80001,
    DDCameraViewControllerErrorCannotInitializeDeviceInput = -80002,
    DDCameraViewControllerErrorCannotAddDeviceInput = -80003,
    DDCameraViewControllerErrorNotFoundCaptureDevice = -80004,
};

@interface DDCameraViewController (DDCaptureDeviceInputSwitch)

/**
 Changes current device hardware inputs by removing old ones and adding new inputs. You can invoke this method while the session is running

 @param error On input, specify a pointer to an error object. If changing hardware inputs failed, this pointer will contain an NSError object that describes the problem. You may specify nil for this property.
 @return YES if current device hardware input was changed or NO if it was not.
 */
- (BOOL)switchCaptureDeviceInputWithError:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
