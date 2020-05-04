//
//  DDCameraHints.h
//  DDCameraViewController
//
//  Copyright (c) 2019 dashdevs.com. All rights reserved.
//

NS_INLINE NSString* DDDeviceFlashModeHintText(AVCaptureFlashMode mode) {
    switch (mode) {
        case AVCaptureFlashModeOff: return NSLocalizedString(@"Flash off", nil);
        case AVCaptureFlashModeOn: return NSLocalizedString(@"Flash on", nil);
        case AVCaptureFlashModeAuto: return NSLocalizedString(@"Flash auto", nil);
        default: return NSLocalizedString(@"Flash not found", nil);
    }
};

NS_INLINE NSString* DDDeviceTorchModeHintText(AVCaptureTorchMode mode) {
    switch (mode) {
        case AVCaptureTorchModeOff: return NSLocalizedString(@"Torch off", nil);
        case AVCaptureTorchModeOn: return NSLocalizedString(@"Torch on", nil);
        case AVCaptureTorchModeAuto: return NSLocalizedString(@"Torch auto", nil);
        default: return NSLocalizedString(@"Torch not found", nil);
    }
};
