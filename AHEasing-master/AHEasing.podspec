Pod::Spec.new do |s|
  s.name         = "AHEasing"
  s.version      = "1.3.2"
  s.summary      = "A supplemental library of easing functions for C, C++, and Objective-C."
  s.homepage     = "https://github.com/warrenm/AHEasing"
  s.license      = { :type => 'Unlicense', :file => 'UNLICENSE' }
  s.author       = { "Warren Moore" => "wm@warrenmoore.net" }
  s.source       = { :git => 'https://github.com/warrenm/AHEasing.git', :tag => '1.3.2' }  
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.15'
  s.source_files = "AHEasing/easing.{h,c}", "AHEasing/CAKeyframeAnimation+AHEasing.{h,m}"
  s.public_header_files = "AHEasing/easing.h", "AHEasing/CAKeyframeAnimation+AHEasing.h"
  s.frameworks  = 'QuartzCore'
  s.requires_arc = true
end
