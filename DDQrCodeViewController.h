//
//  DDQrCodeViewController.h
//  DDCameraViewController
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDQrCodeViewControllerDelegate;

/**
 Camera view subclass that allows to scanned QR code
 */
@interface DDQrCodeViewController: DDCameraViewController <AVCaptureMetadataOutputObjectsDelegate>

/**
 Delegate object that will receive events from qr code view controller
 */
@property (weak, nonatomic, nullable) id<DDQrCodeViewControllerDelegate> delegate;

@end

@protocol DDQrCodeViewControllerDelegate <NSObject>

- (void)qrCodeViewController:(DDQrCodeViewController *)controller didTakeScannedResult:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
