//
//  DDCameraView.h
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DDCameraView;

@protocol DDCameraViewDelegate <NSObject>

@optional

- (BOOL)cameraView:(DDCameraView *)cameraView shouldAutorotateVideoToOrientation:(AVCaptureVideoOrientation)orientation;
- (void)cameraView:(DDCameraView *)cameraView didAutorotateVideoToOrientation:(AVCaptureVideoOrientation)orientation;

@end

@interface DDCameraView : UIView

@property (nonatomic, strong, readonly) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, weak) id<DDCameraViewDelegate> delegate;

- (void)setCaptureSession:(nullable AVCaptureSession *)session;

- (void)setVideoGravity:(NSString *)gravity;

- (BOOL)isVideoOrientationSupported;

- (AVCaptureVideoOrientation)videoOrientation;

- (void)setVideoOrientation:(AVCaptureVideoOrientation)orientation;

- (void)startUpdatingVideoOrientation;

- (void)stopUpdatingVideoOrientation;

- (void)setNeedsUpdateVideoOrientation;

@end

NS_ASSUME_NONNULL_END
