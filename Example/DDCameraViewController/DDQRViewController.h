//
//  DDQRViewController.h
//  DDCameraViewController_Example
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDScannerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDQRViewControllerDelegate;

@interface DDQRViewController : DDScannerViewController

@property (weak, nonatomic, nullable) id<DDQRViewControllerDelegate> qrDelegate;

@end

@protocol DDQRViewControllerDelegate <NSObject>

- (void)ddQRViewController:(DDQRViewController *)controller didTakeScannedResult:(NSString * _Nullable)string;

@end

NS_ASSUME_NONNULL_END
