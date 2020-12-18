#
# Be sure to run `pod lib lint DDCameraViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDCameraViewController'
  s.version          = '0.1.0'
  s.summary          = 'A camera view controller build on top of AVFoundation'

  s.homepage         = 'http://dashdevs.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dashdevs llc' => 'hello@dashdevs.com' }
  s.source           = { :git => 'https://github.com/dashdevs/DDCameraViewController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'DDCameraViewController/Classes/**/*'
  s.private_header_files = 'DDCameraViewController/Classes/DDCameraViewController_Private.h'
  
  s.frameworks = 'UIKit', 'AVFoundation'
  
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |subspec|
      subspec.source_files = 'DDCameraViewController/Classes/DDCameraViewController.{h,m}', 'DDCameraViewController/Classes/DDCameraViewController_Private.h'
      subspec.public_header_files = 'DDCameraViewController/Classes/DDCameraViewController.h'
      subspec.dependency 'DDCameraViewController/DDCameraView'
  end
  
  s.subspec 'DDCameraView' do |subspec|
      subspec.source_files = 'DDCameraViewController/Classes/DDCameraView.{h,m}'
      subspec.public_header_files = 'DDCameraViewController/Classes/DDCameraView.h'
  end
  
  s.subspec 'DDCaptureStillImageOutput' do |subspec|
      subspec.source_files = 'DDCameraViewController/Classes/DDCameraViewController+DDCaptureStillImageOutput.{h,m}'
      subspec.public_header_files = 'DDCameraViewController/Classes/DDCameraViewController+DDCaptureStillImageOutput.h'
      subspec.dependency 'DDCameraViewController/Core'
  end
  
  s.subspec 'DDStillImageViewController' do |subspec|
      subspec.source_files = 'DDCameraViewController/Classes/DDStillImageViewController.{h,m}'
      subspec.public_header_files = 'DDCameraViewController/Classes/DDStillImageViewController.h'
      subspec.dependency 'DDCameraViewController/DDCaptureStillImageOutput'
  end
  
  s.subspec 'DDCaptureDeviceInputSwitch' do |subspec|
      subspec.source_files = 'DDCameraViewController/Classes/AVCaptureDevice+DDCaptureDevicePosition.{h,m}',
      'DDCameraViewController/Classes/DDCameraViewController+DDCaptureDeviceInputSwitch.{h,m}'
      subspec.public_header_files = 'DDCameraViewController/Classes/DDCameraViewController+DDCaptureDeviceInputSwitch.h'
      subspec.dependency 'DDCameraViewController/Core'
  end
  
  s.subspec 'DDCaptureDeviceModesSwitch' do |subspec|
      subspec.source_files = 'DDCameraViewController/Classes/AVCaptureDevice+DDCaptureDeviceModesSwitch.{h,m}'
      subspec.public_header_files = 'DDCameraViewController/Classes/AVCaptureDevice+DDCaptureDeviceModesSwitch.h'
  end

end
