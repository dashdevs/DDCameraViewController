//
//  DDStillImageViewController.h
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDStillImageViewControllerDelegate;

/**
 Camera view subclass that allows to capture still images from current capture session
 */
@interface DDStillImageViewController: DDCameraViewController

/**
 Delegate object that will receive events from still image view controller
 */
@property (weak, nonatomic, nullable) id<DDStillImageViewControllerDelegate> delegate;

/**
 A capture output for capturing still images
 */
@property (strong, nonatomic, readonly) AVCaptureStillImageOutput *stillImageOutput;

/**
 Custom UI action that will trigger capturing still image output

 @param sender UI control that initiated action
 */
- (IBAction)takePhotoButtonTapped:(id)sender;

@end


@protocol DDStillImageViewControllerDelegate <NSObject>

/**
 Sent to the delegate object after the capturing still image output.

 @param controller View controller object that initiated the request
 @param photo UIImage object
 */
- (void)stillImageViewController:(DDStillImageViewController *)controller didTakePhoto:(UIImage *)photo;

/**
 Sent to the delegate object if error occured when capturing still image output.

 @param controller View controller object that initiated the request
 @param error Sent to the delegate object if capturing still image output fails, this object describes the problem.
 */
- (void)stillImageViewController:(DDStillImageViewController *)controller didFailWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
