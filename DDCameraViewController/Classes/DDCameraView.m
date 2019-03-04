//
//  DDCameraView.m
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "DDCameraView.h"

@implementation DDCameraView

#define _previewLayer ((AVCaptureVideoPreviewLayer *)self.layer)

AVCaptureVideoOrientation currentVideoOrientation() {
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            return AVCaptureVideoOrientationLandscapeLeft;
        case UIInterfaceOrientationLandscapeRight:
            return AVCaptureVideoOrientationLandscapeRight;
        case UIInterfaceOrientationPortrait:
            return AVCaptureVideoOrientationPortrait;
        case UIInterfaceOrientationPortraitUpsideDown:
            return AVCaptureVideoOrientationPortraitUpsideDown;
        case UIInterfaceOrientationUnknown:
            return AVCaptureVideoOrientationPortrait;
    }
}

+ (Class)layerClass {
    return [AVCaptureVideoPreviewLayer class];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _previewLayer.masksToBounds = YES;
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
}

- (void)dealloc {
    [self stopUpdatingVideoOrientation];
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
    return _previewLayer;
}

- (void)setCaptureSession:(AVCaptureSession *)session {
    _previewLayer.session = session;
    if ([self isVideoOrientationSupported]) {
        [self startUpdatingVideoOrientation];
    } else {
        [self stopUpdatingVideoOrientation];
    }
}

- (void)setVideoGravity:(NSString *)gravity {
    _previewLayer.videoGravity = gravity;
}

- (BOOL)isVideoOrientationSupported {
    return _previewLayer.connection.isVideoOrientationSupported;
}

- (AVCaptureVideoOrientation)videoOrientation {
    return _previewLayer.connection.videoOrientation;
}

- (void)setVideoOrientation:(AVCaptureVideoOrientation)orientation {
    _previewLayer.connection.videoOrientation = orientation;
}

- (void)startUpdatingVideoOrientation {
    [self setNeedsUpdateVideoOrientation];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setNeedsUpdateVideoOrientation)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

- (void)stopUpdatingVideoOrientation {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidChangeStatusBarOrientationNotification
                                                  object:nil];
}

- (void)setNeedsUpdateVideoOrientation {
    AVCaptureVideoOrientation orientation = currentVideoOrientation();
    if (orientation == [self videoOrientation]) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(cameraView:shouldAutorotateVideoToOrientation:)]) {
        if (![self.delegate cameraView:self shouldAutorotateVideoToOrientation:orientation]) {
            return;
        }
    }
    [self setVideoOrientation:orientation];
    if ([self.delegate respondsToSelector:@selector(cameraView:didAutorotateVideoToOrientation:)]) {
        [self.delegate cameraView:self didAutorotateVideoToOrientation:orientation];
    }
}

@end
