//
//  DDQrCodeScannerViewController.m
//  DDCameraViewController_Example
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDQrCodeScannerViewController.h"
#import "DDQrViewController.h"

@interface DDQrCodeScannerViewController () <DDQrViewControllerDelegate>
@end

@implementation DDQrCodeScannerViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDDQrViewController"]) {
        DDQrViewController *viewController = [segue destinationViewController];
        viewController.qrDelegate = self;
    }
}

- (void)ddQrViewController:(DDQrViewController *)controller didTakeScannedResult:(NSString *)string {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Scan Result" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
