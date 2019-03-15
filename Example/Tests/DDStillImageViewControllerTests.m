//
//  DDStillImageViewControllerTests.m
//  DDCameraViewController_Tests
//
//  Copyright (c) 2019 dashdevs.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DDStillImageViewController.h"
#import "OCMock.h"

@interface DDStillImageViewControllerTests : XCTestCase

@end

@implementation DDStillImageViewControllerTests

- (void)testStillImageOutputCreation {
#if !TARGET_IPHONE_SIMULATOR
    DDStillImageViewController *vc = [[DDStillImageViewController alloc] init];
    XCTAssertNotNil(vc.stillImageOutput);
#endif
}

- (void)testTakePicture {
#if !TARGET_IPHONE_SIMULATOR
    DDStillImageViewController *vc = [[DDStillImageViewController alloc] init];
    [vc loadViewIfNeeded];

    id partialVC = OCMPartialMock(vc);
    AVCaptureStillImageOutput *mockOutput = OCMClassMock([AVCaptureStillImageOutput class]);
    OCMStub([partialVC stillImageOutput]).andReturn(mockOutput);
    
    [partialVC takePhotoAction:nil];
    OCMVerify([mockOutput captureStillImageAsynchronouslyFromConnection:[OCMArg any] completionHandler:[OCMArg any]]);
#endif
}

@end
