//
//  AVCaptureDevice+DDCaptureDevicePosition.m
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "AVCaptureDevice+DDCaptureDevicePosition.h"

@implementation AVCaptureDevice (DDCaptureDevicePosition)

+ (AVCaptureDevice *)dd_deviceWithMediaType:(NSString *)mediaType position:(AVCaptureDevicePosition)position {
    if (@available(iOS 10.0, *)) {
        return [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera
                                                  mediaType:mediaType
                                                   position:position];
    } else {
        NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
        for (AVCaptureDevice *device in devices) {
            if (device.position == position) {
                return device;
            }
        }
    }
    return nil;
}

@end
