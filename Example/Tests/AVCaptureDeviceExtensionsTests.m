//
//  AVCaptureDeviceExtensionsTests.m
//  DDCameraViewController_Tests
//
//  Copyright (c) 2019 dashdevs.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "AVCaptureDevice+DDCaptureDeviceModesSwitch.h"

@interface AVCaptureDeviceExtensionsTests : XCTestCase

@end

@implementation AVCaptureDeviceExtensionsTests

- (void)testNoFlash {
#if !TARGET_IPHONE_SIMULATOR
    AVCaptureDevice *realDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *er = nil;
    id partialMockDevice = OCMPartialMock(realDevice);
    OCMStub([partialMockDevice hasFlash]).andReturn(NO);
    
    BOOL hasSwitchedFlashMode = [partialMockDevice dd_switchFlashMode:&er];
    
    XCTAssertFalse(hasSwitchedFlashMode);
    
    XCTAssertEqual(er.domain, DDCaptureDeviceErrorDomain);
    XCTAssertEqual(er.code, DDCaptureDeviceModesErrorNoFlash);
#endif
}

- (void)testFlashModeChangedWhenOff {
#if !TARGET_IPHONE_SIMULATOR
    AVCaptureDevice *realDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    id partialMockDevice = OCMPartialMock(realDevice);
    OCMStub([partialMockDevice flashMode]).andReturn(AVCaptureFlashModeOff);
    
    BOOL hasSwitchedFlashMode = [partialMockDevice dd_switchFlashMode:nil];
    XCTAssertTrue(hasSwitchedFlashMode);
    OCMVerify([partialMockDevice unlockForConfiguration]);
    OCMVerify([partialMockDevice setFlashMode:AVCaptureFlashModeOn]);
#endif
}

- (void)testFlashModeChangedWhenOn {
#if !TARGET_IPHONE_SIMULATOR
    AVCaptureDevice *realDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    id partialMockDevice = OCMPartialMock(realDevice);
    OCMStub([partialMockDevice flashMode]).andReturn(AVCaptureFlashModeOn);

    [partialMockDevice dd_switchFlashMode:nil];
    OCMVerify([partialMockDevice setFlashMode:AVCaptureFlashModeAuto]);
#endif
}

- (void)testFlashModeChangedWhenAuto {
#if !TARGET_IPHONE_SIMULATOR
    AVCaptureDevice *realDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    id partialMockDevice = OCMPartialMock(realDevice);
    OCMStub([partialMockDevice flashMode]).andReturn(AVCaptureFlashModeAuto);
    
    [partialMockDevice dd_switchFlashMode:nil];
    OCMVerify([partialMockDevice setFlashMode:AVCaptureFlashModeOff]);
#endif
}

- (void)testNoTorch {
#if !TARGET_IPHONE_SIMULATOR
    AVCaptureDevice *realDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *er = nil;
    id partialMockDevice = OCMPartialMock(realDevice);
    OCMStub([partialMockDevice hasTorch]).andReturn(NO);
    
    BOOL hasSwitchedFlashMode = [partialMockDevice dd_switchTorchMode:&er];
    
    XCTAssertFalse(hasSwitchedFlashMode);
    
    XCTAssertEqual(er.domain, DDCaptureDeviceErrorDomain);
    XCTAssertEqual(er.code, DDCaptureDeviceModesErrorNoTorch);
#endif
}

- (void)testTorchModeChangedWhenOff {
#if !TARGET_IPHONE_SIMULATOR
    AVCaptureDevice *realDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    id partialMockDevice = OCMPartialMock(realDevice);
    OCMStub([partialMockDevice torchMode]).andReturn(AVCaptureTorchModeOff);
    
    [partialMockDevice dd_switchTorchMode:nil];
    OCMVerify([partialMockDevice setTorchMode:AVCaptureTorchModeOn]);
#endif
}

- (void)testTorchModeChangedWhenOn {
#if !TARGET_IPHONE_SIMULATOR
    AVCaptureDevice *realDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    id partialMockDevice = OCMPartialMock(realDevice);
    OCMStub([partialMockDevice torchMode]).andReturn(AVCaptureTorchModeOn);
    
    [partialMockDevice dd_switchTorchMode:nil];
    OCMVerify([partialMockDevice setTorchMode:AVCaptureTorchModeAuto]);
#endif
}

- (void)testTorchModeChangedWhenAuto {
#if !TARGET_IPHONE_SIMULATOR
    AVCaptureDevice *realDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    id partialMockDevice = OCMPartialMock(realDevice);
    OCMStub([partialMockDevice torchMode]).andReturn(AVCaptureTorchModeAuto);
    
    [partialMockDevice dd_switchTorchMode:nil];
    OCMVerify([partialMockDevice setTorchMode:AVCaptureTorchModeOff]);
#endif
}


@end
