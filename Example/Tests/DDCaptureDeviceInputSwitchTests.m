//
//  DDCaptureDeviceInputSwitchTests.m
//  DDCameraViewController_Tests
//
//  Copyright (c) 2019 dashdevs.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DDCameraViewController+DDCaptureDeviceInputSwitch.h"
#import "OCMock.h"
#import "AVCaptureDevice+DDCaptureDevicePosition.h"

@interface DDCaptureDeviceInputSwitchTests : XCTestCase

@end

@implementation DDCaptureDeviceInputSwitchTests

- (void)testNoSession {
#if TARGET_IPHONE_SIMULATOR
    DDCameraViewController *vc = [[DDCameraViewController alloc] init];
    [vc loadViewIfNeeded];
    XCTAssertNil(vc.captureSession);
    NSError *er = nil;
    
    BOOL hasSwitchedInput = [vc switchCaptureDeviceInputWithError:&er];
    XCTAssertFalse(hasSwitchedInput);
    XCTAssertEqual(er.code, DDCameraViewControllerErrorNotInitializedCaptureSession);
#else
    DDCameraViewController *vc = [[DDCameraViewController alloc] init];
    [vc loadViewIfNeeded];
    XCTAssertNotNil(vc.captureSession);
    
    id partialVCMock = OCMPartialMock(vc);
    OCMStub([partialVCMock captureSession]).andReturn(nil);  // simulate capture session initialisation failure
    NSError *er = nil;
    
    BOOL hasSwitchedInput = [vc switchCaptureDeviceInputWithError:&er];
    XCTAssertFalse(hasSwitchedInput);
    XCTAssertEqual(er.code, DDCameraViewControllerErrorNotInitializedCaptureSession);
#endif
}

- (void)testNoCameraFound {
#if !TARGET_IPHONE_SIMULATOR
    DDCameraViewController *vc = [[DDCameraViewController alloc] init];
    [vc loadViewIfNeeded];
    XCTAssertNotNil(vc.captureSession);
    
    id partialVCMock = OCMPartialMock(vc);
    OCMStub([partialVCMock captureDevice]).andReturn(nil);  // simulate camera hardware absence
    NSError *er = nil;
    
    BOOL hasSwitchedInput = [partialVCMock switchCaptureDeviceInputWithError:&er];
    XCTAssertFalse(hasSwitchedInput);
    XCTAssertEqual(er.code, DDCameraViewControllerErrorNotInitializedCaptureDevice);
#endif
}

- (void)testCameraSwitchFailure {
#if !TARGET_IPHONE_SIMULATOR
    DDCameraViewController *vc = [[DDCameraViewController alloc] init];
    [vc loadViewIfNeeded];
    XCTAssertNotNil(vc.captureSession);
    
    AVCaptureDevice *partialCameraMock = OCMPartialMock(vc.captureDevice);
    OCMStub([partialCameraMock position]).andReturn(AVCaptureDevicePositionBack);
    
    id classMock = OCMClassMock([AVCaptureDevice class]);
    // simulating case when error occured while transitioning from back to front camera
    OCMStub([classMock dd_deviceWithMediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront]).andReturn(nil);
    
    NSError *er = nil;
    BOOL hasSwitchedInput = [vc switchCaptureDeviceInputWithError:&er];
    XCTAssertFalse(hasSwitchedInput);
    XCTAssertEqual(er.code, DDCameraViewControllerErrorNotFoundCaptureDevice);
#endif
}

- (void)testCameraSwitchSuccessCase {
#if !TARGET_IPHONE_SIMULATOR
    DDCameraViewController *vc = [[DDCameraViewController alloc] init];
    [vc loadViewIfNeeded];
    id sessionMock = OCMPartialMock(vc.captureSession);

    NSError *er = nil;
    AVCaptureInput *previousInput = vc.deviceInput;
    BOOL hasSwitchedInput = [vc switchCaptureDeviceInputWithError:&er];
    XCTAssertTrue(hasSwitchedInput);

    OCMVerify([sessionMock beginConfiguration]);
    OCMVerify([sessionMock removeInput:previousInput]);
    OCMVerify([sessionMock commitConfiguration]);
#endif
}

@end
