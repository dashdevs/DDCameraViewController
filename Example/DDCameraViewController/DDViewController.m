//
//  DDViewController.m
//  DDCameraViewController_Example
//
//  Copyright (c) 2020 dashdevs.com. All rights reserved.
//

#import "DDViewController.h"
#import "DDScannerCameraViewController.h"

@interface DDViewController () <DDScannerCameraViewControllerDelegate>
@end

@implementation DDViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDDScannerCameraViewController"]) {
        DDScannerCameraViewController *viewController = [segue destinationViewController];
        viewController.qrDelegate = self;
    }
}

- (void)ddScannerCameraViewController:(DDScannerCameraViewController *)controller didTakeScannedResult:(NSString * _Nullable)string {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Scan Result" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
