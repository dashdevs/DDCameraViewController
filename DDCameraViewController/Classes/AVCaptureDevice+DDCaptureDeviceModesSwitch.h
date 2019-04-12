//
//  AVCaptureDevice+DDCaptureDeviceModesSwitch.h
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 Constant used by NSError to differentiate between "domains" of error codes
 */
extern NSString *const DDCaptureDeviceErrorDomain;

/**
 This enum describes codes for errors that may arrise while discovering existing device functionality

 - DDCaptureDeviceLockError: When attempting to configure the hardware related properties of the device you should lock configuration. This error code describes case when a lock cannot be acquired
 - DDCaptureDeviceModesErrorNoFlash: Current device does not have flash
 - DDCaptureDeviceModesErrorNoTorch: Current device does not have torch
 */
NS_ENUM (NSInteger) {
    DDCaptureDeviceLockError = -81000,
    DDCaptureDeviceModesErrorNoFlash = -81001,
    DDCaptureDeviceModesErrorNoTorch = -81002,
};

/**
 This category adds convenience methods to changing different device hardware modes
 */
@interface AVCaptureDevice (DDCaptureDeviceModesSwitch)

/**
 This method allows you to change current device flash mode. Method returns error if device's camera has no flash functionality or if when device hardware configration lock cannot be acquired.

 @param error On input, specify a pointer to an error object. If flash mode cannot be changed, this pointer contains an NSError object that describes the problem. You may specify nil for this property.
 @return YES if a camera flash mode was changed or NO if it was not.
 */
- (BOOL)dd_switchFlashMode:(NSError **)error;

/**
 This method allows you to toggle current device torch mode. Method returns error if device's camera has no torch functionality or if when device hardware configration lock cannot be acquired.

 @param error On input, specify a pointer to an error object. If torch mode cannot be toggled, this pointer contains an NSError object that describes the problem. You may specify nil for this property.
 @return YES if a camera torch mode was toggled or NO if it was not.
 */
- (BOOL)dd_switchTorchMode:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
