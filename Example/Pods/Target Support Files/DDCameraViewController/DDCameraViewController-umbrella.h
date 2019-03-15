#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AVCaptureDevice+DDCaptureDeviceModesSwitch.h"
#import "AVCaptureDevice+DDCaptureDevicePosition.h"
#import "DDCameraView.h"
#import "DDCameraViewController+DDCaptureDeviceInputSwitch.h"
#import "DDCameraViewController+DDCaptureStillImageOutput.h"
#import "DDCameraViewController.h"
#import "DDCameraViewController_Private.h"
#import "DDStillImageViewController.h"
#import "DDCameraView.h"
#import "DDCameraViewController.h"

FOUNDATION_EXPORT double DDCameraViewControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char DDCameraViewControllerVersionString[];

