//
//  DDQRCodeScannerViewController.m
//  DDCameraViewController_Example
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDQRCodeScannerViewController.h"
#import "DDQRViewController.h"

@interface DDQRCodeScannerViewController () <DDQRViewControllerDelegate>
@end

@implementation DDQRCodeScannerViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDDQRViewController"]) {
        DDQRViewController *viewController = [segue destinationViewController];
        viewController.qrDelegate = self;
    }
}

- (void)ddQRViewController:(DDQRViewController *)controller didTakeScannedResult:(NSString *)string {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Scan Result" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
