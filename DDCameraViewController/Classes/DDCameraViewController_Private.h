//
//  DDCameraViewController_Private.h
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController.h"

NS_ASSUME_NONNULL_BEGIN

static dispatch_queue_t dd_capture_session_queue() {
    static dispatch_queue_t capture_session_queue;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        capture_session_queue = dispatch_queue_create("com.dashdevs.capture.session", DISPATCH_QUEUE_SERIAL);
    });
    return capture_session_queue;
}

@interface DDCameraViewController ()

@property (nonatomic, strong, readwrite, nullable) AVCaptureSession *captureSession;

@property (nonatomic, strong, readwrite, nullable) AVCaptureDevice *captureDevice;

@property (nonatomic, strong, readwrite, nullable) AVCaptureDeviceInput *deviceInput;

@end

NS_ASSUME_NONNULL_END
