//
//  DDCameraViewController+DDCaptureStillImageOutput.h
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCameraViewController (DDCaptureStillImageOutput)

- (AVCaptureStillImageOutput *_Nullable)addStillImageOutputWithVideoCodec:(NSString *)codec;

- (void)removeStillImageOutput:(AVCaptureStillImageOutput *)output;

@end

NS_ASSUME_NONNULL_END
