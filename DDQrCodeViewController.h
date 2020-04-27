//
//  DDQrCodeViewController.h
//  DDCameraViewController
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDCameraViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDQrCodeViewControllerDelegate;

/**
 Camera view subclass that allows to capture scanned result from current capture session
 */
@interface DDQrCodeViewController: DDCameraViewController

/**
 Delegate object that will receive events from qr code view controller
 */
@property (weak, nonatomic, nullable) id<DDQrCodeViewControllerDelegate> delegate;

@end

@protocol DDQrCodeViewControllerDelegate <NSObject>

- (void)qrCodeViewController:(DDQrCodeViewController *)controller didTakeScannedResult:(NSString *)string;
- (void)qrCodeViewController:(DDQrCodeViewController *)controller didFailWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
