//
//  DDCameraViewController+DDCaptureStillImageOutput.h
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCameraViewController (DDCaptureStillImageOutput)

/**
 Adds possibility to capture, on demand, high quality snapshots from a realtime capture source

 @param codec Name of the codec used to encode the video. You can use H.264, HEVC, or JPEG video compression format, depending on the video codec types available in AVCaptureMovieFileOutput. Check available video codec types by consulting availableVideoCodecTypes.
 @return An AVCaptureStillImageOutput instance associated with capture session
 */
- (AVCaptureStillImageOutput *_Nullable)addStillImageOutputWithVideoCodec:(NSString *)codec;

/**
 Removes a given output from capture session
 
 @param output An output to remove from the capture session
 */
- (void)removeStillImageOutput:(AVCaptureStillImageOutput *)output;

@end

NS_ASSUME_NONNULL_END
