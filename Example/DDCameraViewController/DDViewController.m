//
//  DDViewController.m
//  DDCameraViewController
//
//  Copyright (c) 2019 dashdevs.com. All rights reserved.
//

#import "DDViewController.h"
#import "DDScannerCameraViewController.h"

@interface DDViewController ()<DDScannerCameraViewControllerDelegate>
@end

@implementation DDViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDDScannerCameraViewController"]) {
        DDScannerCameraViewController *viewController = [segue destinationViewController];
        viewController.scannerDelegate = self;
    }
}

- (void)scannerCameraViewController:(DDScannerCameraViewController *)controller didScanMachineReadableCode:(NSString * _Nullable)code {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Scan Result" message:code preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
