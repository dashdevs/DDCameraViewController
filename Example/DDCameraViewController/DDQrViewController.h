//
//  DDQrViewController.h
//  DDCameraViewController_Example
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDQrCodeViewController.h"

@protocol DDQrViewControllerDelegate;

@interface DDQrViewController : DDQrCodeViewController

@property (weak, nonatomic) id<DDQrViewControllerDelegate> qrDelegate;

@end

@protocol DDQrViewControllerDelegate <NSObject>

- (void)ddQrViewController:(DDQrViewController *)controller didTakeScannedResult:(NSString *)string;

@end
