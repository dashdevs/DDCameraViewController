//
//  DDQRViewController.h
//  DDCameraViewController_Example
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDQRCodeViewController.h"

@protocol DDQRViewControllerDelegate;

@interface DDQRViewController : DDQRCodeViewController

@property (weak, nonatomic) id<DDQRViewControllerDelegate> qrDelegate;

@end

@protocol DDQRViewControllerDelegate <NSObject>

- (void)ddQRViewController:(DDQRViewController *)controller didTakeScannedResult:(NSString *)string;

@end
