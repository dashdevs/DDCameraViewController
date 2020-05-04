//
//  DDViewController.m
//  DDCameraViewController_Example
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDViewController.h"
#import "DDQRViewController.h"

@interface DDViewController () <DDQRViewControllerDelegate>
@end

@implementation DDViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDDScannerCameraViewController"]) {
        DDQRViewController *viewController = [segue destinationViewController];
        viewController.qrDelegate = self;
    }
}

- (void)ddQRViewController:(DDQRViewController *)controller didTakeScannedResult:(NSString * _Nullable)string {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Scan Result" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
