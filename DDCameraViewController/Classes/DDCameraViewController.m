//
//  DDCameraViewController.m
//  DDCameraViewController
//
//  Copyright (c) 2017 dashdevs.com. All rights reserved.
//

#import "DDCameraViewController.h"
#import "DDCameraViewController_Private.h"

NSString *const DDCameraViewControllerErrorDomain = @"DDCameraViewControllerErrorDomain";

@implementation DDCameraViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeCaptureSession];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initializeCaptureSession];
    }
    return self;
}

- (void)loadView {
    if (self.nibName == nil) {
        self.view = self.cameraView;
        return;
    }
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cameraView setCaptureSession:self.captureSession];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startRunningCaptureSession];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startRunningCaptureSession) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopRunningCaptureSession) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [self stopRunningCaptureSession];
    [super viewWillDisappear:animated];
}

#pragma mark - Custom accessors

- (DDCameraView *)cameraView {
    if (!_cameraView) {
        [self loadCameraView];
    }
    return _cameraView;
}

#pragma mark - Public methods

- (void)initializeCaptureSession {
    AVCaptureSession *session = nil;
    NSError *error = nil;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (input != nil) {
        session = [[AVCaptureSession alloc] init];
        if ([session canAddInput:input]) {
            [session addInput:input];
        }
    } else {
        NSLog(@"Failed to initialize a camera input with error: %@", error.localizedDescription);
    }
    _deviceInput = input;
    _captureDevice = device;
    _error = error;
    _captureSession = session;
}

- (void)loadCameraView {
    _cameraView = [[DDCameraView alloc] init];
    _cameraView.delegate = self;
}

- (BOOL)isCameraViewLoaded {
    return _cameraView != nil;
}

#pragma mark - Private methods

- (void)startRunningCaptureSession {
    dispatch_async(dd_capture_session_queue(), ^{
        [self.captureSession startRunning];
    });
}

- (void)stopRunningCaptureSession {
    dispatch_async(dd_capture_session_queue(), ^{
        [self.captureSession stopRunning];
    });
}

@end
