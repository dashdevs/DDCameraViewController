//
//  DDCaptureStillImageOutputTests.m
//  DDCameraViewController_Tests
//
//  Copyright (c) 2019 dashdevs.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DDCameraViewController+DDCaptureStillImageOutput.h"

@interface DDCaptureStillImageOutputTests : XCTestCase

@end

@implementation DDCaptureStillImageOutputTests

- (void)testAddStillImageOutput {
#if !TARGET_IPHONE_SIMULATOR
    DDCameraViewController *vc = [[DDCameraViewController alloc] init];
    [vc loadViewIfNeeded];
    
    NSInteger outputCount = vc.captureSession.outputs.count;
    AVCaptureStillImageOutput *output = [vc addStillImageOutputWithVideoCodec:AVVideoCodecJPEG];
    XCTAssertEqual(outputCount + 1, vc.captureSession.outputs.count);
    XCTAssertNotNil(output);
#endif
}

- (void)testRemoveStillImageOutput {
#if !TARGET_IPHONE_SIMULATOR
    DDCameraViewController *vc = [[DDCameraViewController alloc] init];
    [vc loadViewIfNeeded];
    
    AVCaptureStillImageOutput *output = [vc addStillImageOutputWithVideoCodec:AVVideoCodecJPEG];
    NSInteger outputCount = vc.captureSession.outputs.count;
    [vc removeStillImageOutput:output];
    XCTAssertEqual(outputCount - 1, vc.captureSession.outputs.count);
#endif
}

@end
