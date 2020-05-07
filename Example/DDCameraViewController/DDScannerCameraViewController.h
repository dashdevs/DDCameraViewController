//
//  DDScannerCameraViewController.h
//  DDCameraViewController
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDScannerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDScannerCameraViewControllerDelegate;

@interface DDScannerCameraViewController : DDScannerViewController

@property (weak, nonatomic, nullable) id<DDScannerCameraViewControllerDelegate> qrDelegate;

@end

@protocol DDScannerCameraViewControllerDelegate <NSObject>

- (void)scannerCameraViewController:(DDScannerCameraViewController *)controller didScanMachineReadableCode:(NSString * _Nullable)code;

@end

NS_ASSUME_NONNULL_END
