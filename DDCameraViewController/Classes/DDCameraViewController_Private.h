//
//  DDCameraViewController_Private.h
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCameraViewController ()

@property (nonatomic, strong, readwrite, nullable) AVCaptureSession *captureSession;

@property (nonatomic, strong, readwrite, nullable) AVCaptureDevice *captureDevice;

@property (nonatomic, strong, readwrite, nullable) AVCaptureDeviceInput *deviceInput;

@end

NS_ASSUME_NONNULL_END
