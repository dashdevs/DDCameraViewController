//
//  DDCameraViewTests.m
//  DDCameraViewController_Tests
//
//  Copyright (c) 2019 dashdevs.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DDCameraView.h"
#import "OCMock.h"

@interface DDCameraViewTests : XCTestCase

@end

@implementation DDCameraViewTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testPreviewLayerExistance {
    DDCameraView *camera = [DDCameraView new];
    XCTAssertNotNil(camera.previewLayer);
}

- (void)testSetGravity {
    DDCameraView *camera = [DDCameraView new];
    [camera setVideoGravity:AVLayerVideoGravityResizeAspect];
    XCTAssertEqual(camera.previewLayer.videoGravity, AVLayerVideoGravityResizeAspect);
}

- (void)testCameraSupportsUpdatingOrientation {
    DDCameraView *camera = [DDCameraView new];
    id partialCameraMock = OCMPartialMock(camera);

    OCMStub([partialCameraMock isVideoOrientationSupported]).andReturn(YES);
    [partialCameraMock setCaptureSession: nil];
    OCMVerify([partialCameraMock startUpdatingVideoOrientation]);
}

- (void)testCameraDoesNotSupportUpdatingOrientation {
    DDCameraView *camera = [DDCameraView new];
    id partialCameraMock = OCMPartialMock(camera);
    
    OCMStub([partialCameraMock isVideoOrientationSupported]).andReturn(NO);
    [partialCameraMock setCaptureSession: nil];
    OCMVerify([partialCameraMock stopUpdatingVideoOrientation]);
}

- (void)testSetVideoOrientationFromRightToLeftLandscape {
    DDCameraView *camera = [DDCameraView new];
    UIApplication *app = [UIApplication sharedApplication];
    id partialCameraMock = OCMPartialMock(camera);
    id partialAppMock = OCMPartialMock(app);
    
    OCMStub([partialAppMock statusBarOrientation]).andReturn(UIInterfaceOrientationLandscapeLeft);
    OCMStub([partialCameraMock videoOrientation]).andReturn(AVCaptureVideoOrientationLandscapeRight);
    
    [partialCameraMock setNeedsUpdateVideoOrientation];
    OCMVerify([partialCameraMock setVideoOrientation:AVCaptureVideoOrientationLandscapeLeft]);
}

- (void)testtestSetVideoOrientationDelegating {
    DDCameraView *camera = [DDCameraView new];
    id fakeDelegate = OCMProtocolMock(@protocol(DDCameraViewDelegate));
    camera.delegate = fakeDelegate;
    
    UIApplication *app = [UIApplication sharedApplication];
    id partialCameraMock = OCMPartialMock(camera);
    id partialAppMock = OCMPartialMock(app);
    
    OCMStub([partialAppMock statusBarOrientation]).andReturn(UIInterfaceOrientationLandscapeLeft);
    OCMStub([partialCameraMock videoOrientation]).andReturn(AVCaptureVideoOrientationLandscapeRight);
    
    OCMStub([fakeDelegate cameraView:camera shouldAutorotateVideoToOrientation:AVCaptureVideoOrientationLandscapeLeft]).andReturn(YES);

    [partialCameraMock setNeedsUpdateVideoOrientation];
    OCMVerify([fakeDelegate cameraView:camera didAutorotateVideoToOrientation:AVCaptureVideoOrientationLandscapeLeft]);
}

@end
