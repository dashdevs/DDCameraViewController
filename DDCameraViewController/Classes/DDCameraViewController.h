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

/**
 This is base class that extends plain UIViewController with camera functionality
 */
@interface DDCameraViewController : UIViewController <DDCameraViewDelegate>

/**
 An object that manages capture activity and coordinates the flow of data from camera hardware to capture outputs
 */
@property (nonatomic, strong, readonly, nullable) AVCaptureSession *captureSession;

/**
 Object that represents a physical capture hardware and the properties associated with that hardware
 */
@property (nonatomic, strong, readonly, nullable) AVCaptureDevice *captureDevice;

/**
 A capture input that provides media from a capture hardware to a capture session.
 */
@property (nonatomic, strong, readonly, nullable) AVCaptureDeviceInput *deviceInput;

/**
 Object contains an NSError object that describes the problem occured while
 */
@property (nonatomic, copy, readonly, nullable) NSError *error;

/**
 View object that provides extended capturing functionality
 */
@property (nonatomic, strong, null_resettable) IBOutlet DDCameraView *cameraView;

/**
 Creates capture session objects, associates it with deviceInput, captureDevice and deviceInput objects
 */
- (void)initializeCaptureSession;

/**
 Creates camera view that is managed by DDCameraViewController
 */
- (void)loadCameraView;

/**
 A Boolean value indicating whether the camera view is currently loaded into memory

 @return YES when the view is in memory or NO when it is not.
 */
- (BOOL)isCameraViewLoaded;

@end

NS_ASSUME_NONNULL_END
