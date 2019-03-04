//
//  AVCaptureDevice+DDCaptureDeviceModesSwitch.h
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const DDCaptureDeviceErrorDomain;

NS_ENUM (NSInteger) {
    DDCaptureDeviceLockError = -81000,
    DDCaptureDeviceModesErrorNoFlash = -81001,
    DDCaptureDeviceModesErrorNoTorch = -81002,
};

@interface AVCaptureDevice (DDCaptureDeviceModesSwitch)

- (BOOL)dd_switchFlashMode:(NSError **)error;

- (BOOL)dd_switchTorchMode:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
