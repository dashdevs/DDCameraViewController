//
//  AVCaptureDevice+DDCaptureDevicePosition.h
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVCaptureDevice (DDCaptureDevicePosition)

+ (nullable AVCaptureDevice *)dd_deviceWithMediaType:(NSString *)mediaType position:(AVCaptureDevicePosition)position;

@end

NS_ASSUME_NONNULL_END
