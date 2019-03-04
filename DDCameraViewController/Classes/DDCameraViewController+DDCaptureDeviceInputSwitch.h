//
//  DDCameraViewController+DDCaptureDeviceInputSwitch.h
//  DDCameraViewController
//
//  Copyright (c) 2019 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController.h"

NS_ASSUME_NONNULL_BEGIN

NS_ENUM (NSInteger) {
    DDCameraViewControllerErrorNotInitializedCaptureSession = -80000,
    DDCameraViewControllerErrorNotInitializedCaptureDevice = -80001,
    DDCameraViewControllerErrorCannotInitializeDeviceInput = -80002,
    DDCameraViewControllerErrorCannotAddDeviceInput = -80003,
    DDCameraViewControllerErrorNotFoundCaptureDevice = -80004,
};

@interface DDCameraViewController (DDCaptureDeviceInputSwitch)

- (BOOL)switchCaptureDeviceInputWithError:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
