//
//  AVCaptureDevice+DDCaptureDevicePosition.h
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 This category adds convenience methods for selecting available capture device
 */
@interface AVCaptureDevice (DDCaptureDevicePosition)

/**
 Use this method to easily select the system default capture device for a given scenario. When available method uses a built-in wide angle camera device type

 @param mediaType The type of media to request capture of, such as AVMediaTypeAudio. See Media Types
 @param position The position of capture device to request relative to system hardware (front- or back-facing). Pass AVCaptureDevicePositionUnspecified to search for devices regardless of position.
 @return The system default device for the specified combination of media type and position, or nil if no currently available device satisfies the specified criteria.
 */
+ (nullable AVCaptureDevice *)dd_deviceWithMediaType:(NSString *)mediaType position:(AVCaptureDevicePosition)position;

@end

NS_ASSUME_NONNULL_END
