//
//  DDCameraViewControllerTests.m
//  DDCameraViewController_Tests
//
//  Copyright (c) 2019 dashdevs.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DDCameraViewController.h"
#import "OCMock.h"
#import "NSNotificationCenter+OCMAdditions.h"
#import <AVFoundation/AVFoundation.h>

@interface DDCameraViewControllerTests : XCTestCase

@end

@implementation DDCameraViewControllerTests

- (void)testInitialising {
    DDCameraViewController *vc = [[DDCameraViewController alloc] init];
    [vc loadViewIfNeeded];
    XCTAssertTrue([vc.view isKindOfClass:[DDCameraView class]]);
    XCTAssertTrue(vc.isCameraViewLoaded);
}

- (void)testVerifyingCameraInteractions {
#if TARGET_IPHONE_SIMULATOR
    id mockCameraView = OCMClassMock([DDCameraView class]);
    DDCameraViewController *vc = [[DDCameraViewController alloc] init];
    vc.cameraView = mockCameraView;
    
    [vc loadViewIfNeeded];
    OCMVerify([mockCameraView setCaptureSession:nil]);
    XCTAssertNotNil(vc.error);
#endif
}

@end
