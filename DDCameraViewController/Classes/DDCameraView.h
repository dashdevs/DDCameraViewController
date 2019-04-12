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

/**
 DDCameraViewDelegate specifies the methods that a camera view delegate object may respond to.
 */
@protocol DDCameraViewDelegate <NSObject>

@optional

/**
 Returns a Boolean value indicating whether the camera view supports the specified video orientation.

 @param cameraView View object that initiated the request
 @param orientation The orientation of the app's user interface after the rotation. The possible values are described in AVCaptureVideoOrientation enum
 @return YES if the view auto-rotates to the specified orientation; otherwise, NO.
 */
- (BOOL)cameraView:(DDCameraView *)cameraView shouldAutorotateVideoToOrientation:(AVCaptureVideoOrientation)orientation;

/**
 Sent to the camera view after the video orientation changes.

 @param cameraView View object that initiated the request
 @param orientation The new orientation for the video. The possible values are described in AVCaptureVideoOrientation enum
 */
- (void)cameraView:(DDCameraView *)cameraView didAutorotateVideoToOrientation:(AVCaptureVideoOrientation)orientation;

@end

/**
 Object that extends plain UIView functionality by adding previewing the visual output of capture session
 */
@interface DDCameraView : UIView

/**
 A Core Animation layer of camera view object used for previewing the visual output of the specified AVCaptureSession
 */
@property (nonatomic, strong, readonly) AVCaptureVideoPreviewLayer *previewLayer;

/**
 Delegate object which will receive events from camera view 
 */
@property (nonatomic, weak) id<DDCameraViewDelegate> delegate;

/**
 Associates capture session and preview layer of camera view object.

 @param session The capture session object from which to derive the preview
 */
- (void)setCaptureSession:(nullable AVCaptureSession *)session;

/**
 Indicates how the video is displayed within a preview layer’s bounds rect

 @param gravity Options are AVLayerVideoGravityResizeAspect, AVLayerVideoGravityResizeAspectFill and AVLayerVideoGravityResize. The default is AVLayerVideoGravityResizeAspect.
 This property is animatable
 */
- (void)setVideoGravity:(NSString *)gravity;

/**
 A Boolean value that indicates whether the preview layer supports changing the orientation of the video.

 @return YES if preview layer supports changing the orientation of the video, NO otherwise
 */
- (BOOL)isVideoOrientationSupported;

/**
 The orientation of the video that is previewing by previewLayer.

 @return current video orientation displayed by previewLayer
 */
- (AVCaptureVideoOrientation)videoOrientation;

/**
 Sets orientation of video previewing by previewLayer

 @param orientation Video orientation to set
 */
- (void)setVideoOrientation:(AVCaptureVideoOrientation)orientation;

/**
 Starts the generation of updates of video orientation of video previewing by previewLayer
 */
- (void)startUpdatingVideoOrientation;

/**
 Stops the generation of video orientation updates
 */
- (void)stopUpdatingVideoOrientation;

/**
 Indicates to the system that the video orientation attributes have changed.
 */
- (void)setNeedsUpdateVideoOrientation;

@end

NS_ASSUME_NONNULL_END
