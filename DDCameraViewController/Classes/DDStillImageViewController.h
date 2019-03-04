//
//  DDStillImageViewController.h
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController.h"

@protocol DDStillImageViewControllerDelegate;

@interface DDStillImageViewController : DDCameraViewController

@property (weak, nonatomic) id<DDStillImageViewControllerDelegate> delegate;

@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;

- (IBAction)takePhotoButtonTapped:(id)sender;

@end


@protocol DDStillImageViewControllerDelegate <NSObject>

- (void)stillImageViewController:(DDStillImageViewController *)controller didTakePhoto:(UIImage *)photo;

- (void)stillImageViewController:(DDStillImageViewController *)controller didFailWithError:(NSError *)error;

@end
