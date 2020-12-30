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

/**
 Adds the ability to set possible scan types.
 
 @param types The value of this property is an NSArray of NSStrings corresponding to AVMetadataObjectType strings defined in AVMetadataObject.h -- one for each metadata object type supported by the receiver. Clients may specify the types of objects they would like to process by calling setMetadataObjectTypes:.
 */
- (void)setMetadataObjectTypes:(NSArray<AVMetadataObjectType> * _Nullable)types;

@end

@protocol DDScannerViewControllerDelegate <NSObject>

/**
 Sent to the delegate object after scanning.

 @param controller View controller object that initiated the request.
 @param code The scanned information is sent as a string to the delegate object.
 */
- (void)scannerViewController:(DDScannerViewController *)controller didScanMachineReadableCode:(NSString * _Nullable)code;

@end

NS_ASSUME_NONNULL_END
