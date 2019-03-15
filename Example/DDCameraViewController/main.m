//
//  main.m
//  DDCameraViewController
//
//  Copyright (c) 2019 dashdevs.com. All rights reserved.
//

@import UIKit;

#import "DDAppDelegate.h"
#import "DDTestAppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        Class appdelegateClass = NSClassFromString(@"DDTestAppDelegate");
        if (!appdelegateClass) {
            appdelegateClass = [DDAppDelegate class];
        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass(appdelegateClass));
    }
}
