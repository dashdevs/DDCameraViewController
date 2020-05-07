//
//  DDScannerViewController.h
//  DDCameraViewController
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDScannerViewControllerDelegate;

/**
 Camera view subclass that allows to scanned 
 */
@interface DDScannerViewController: DDCameraViewController

/**
 Delegate object that will receive events from code view controller
 */
@property (weak, nonatomic, nullable) id<DDScannerViewControllerDelegate> delegate;

- (void)setMetadataObjectTypes:(NSArray<AVMetadataObjectType> * _Nullable)types;

@end

@protocol DDScannerViewControllerDelegate <NSObject>

- (void)ddScannerViewController:(DDScannerViewController *)controller didTakeScannedResult:(NSString * _Nullable)resultAsString;

@end

NS_ASSUME_NONNULL_END
