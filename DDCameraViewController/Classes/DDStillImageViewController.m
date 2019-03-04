//
//  DDStillImageViewController.m
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "DDStillImageViewController.h"
#import "DDCameraViewController+DDCaptureStillImageOutput.h"

@implementation DDStillImageViewController

- (void)initializeCaptureSession {
    [super initializeCaptureSession];
    self.stillImageOutput = [self addStillImageOutputWithVideoCodec:AVVideoCodecJPEG];
}

- (IBAction)takePhotoButtonTapped:(id)sender {
    AVCaptureConnection *connection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (error) {
            if ([self.delegate respondsToSelector:@selector(stillImageViewController:didFailWithError:)]) {
                [self.delegate stillImageViewController:self didFailWithError:error];
            }
            return;
        }
        NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [[UIImage alloc] initWithData:data];
        if ([self.delegate respondsToSelector:@selector(stillImageViewController:didTakePhoto:)]) {
            [self.delegate stillImageViewController:self didTakePhoto:image];
        }
    }];
}

@end
