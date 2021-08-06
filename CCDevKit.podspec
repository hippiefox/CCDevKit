#
# Be sure to run `pod lib lint CCDevKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CCDevKit'
  s.version          = '0.1.1'
  s.summary          = 'A short description of CCDevKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

 
  s.homepage         = 'https://github.com/hippiefox/CCDevKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ccczuo' => '229569731@qq.com' }
  s.source           = { :git => 'https://github.com/hippiefox/CCDevKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'

  s.source_files = 'CCDevKit/Classes/**/*.{h,m,swift}'
  
  # s.resource_bundles = {
  #   'CCDevKit' => ['CCDevKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
    s.dependency "Cache", '~>5.3.0'
  s.dependency 'Moya','~>13.0.1'
  s.dependency 'SwiftyJSON', '~> 4.0'
  s.dependency 'MBProgressHUD', '~> 1.2.0'
  s.dependency 'KeychainAccess', '~> 4.2.1'
end
