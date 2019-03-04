//
//  DDCameraViewController.h
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDCameraView.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const DDCameraViewControllerErrorDomain;

@interface DDCameraViewController : UIViewController <DDCameraViewDelegate>

@property (nonatomic, strong, readonly, nullable) AVCaptureSession *captureSession;

@property (nonatomic, strong, readonly, nullable) AVCaptureDevice *captureDevice;

@property (nonatomic, strong, readonly, nullable) AVCaptureDeviceInput *deviceInput;

@property (nonatomic, copy, readonly, nullable) NSError *error;

@property (nonatomic, strong, null_resettable) IBOutlet DDCameraView *cameraView;

- (void)initializeCaptureSession;

- (void)loadCameraView;

- (BOOL)isCameraViewLoaded;

@end

NS_ASSUME_NONNULL_END
