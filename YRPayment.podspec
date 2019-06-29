#
#  Be sure to run `pod spec lint YRPayment.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  

  spec.name         = "YRPayment"
  spec.version      = "1.0"
  spec.summary      = "Better payment experience library in Swift."

  spec.description  = <<-DESC
Better payment user experience library with cool animation in Swift.
                   DESC

  spec.homepage     = "https://github.com/yassram/YRPayment"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
 
 
  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
 

  spec.author             = { "yassir ramdani" => "ramsserio@gmail.com" }
 
 
  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  
  spec.ios.deployment_target = "11.0"
  spec.swift_version = "4.2"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  

  spec.source       = { :git => "https://github.com/yassram/YRPayment.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  

  spec.source_files  = "YRPayment", "YRPayment/**/*.{h,m,swift}"
  

end
