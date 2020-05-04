//
//  DDQRCodeViewController.h
//  DDCameraViewController
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDQRCodeViewControllerDelegate;

/**
 Camera view subclass that allows to scanned QR code
 */
@interface DDQRCodeViewController: DDCameraViewController

/**
 Delegate object that will receive events from qr code view controller
 */
@property (weak, nonatomic, nullable) id<DDQRCodeViewControllerDelegate> delegate;

- (void)setMetadataObjectTypes:(NSArray<AVMetadataObjectType> * _Nullable)types;

@end

@protocol DDQRCodeViewControllerDelegate <NSObject>

- (void)ddQRCodeViewController:(DDQRCodeViewController *)controller didTakeScannedResult:(NSString * _Nullable)string;

@end

NS_ASSUME_NONNULL_END
