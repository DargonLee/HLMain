#
# Be sure to run `pod lib lint HLMain.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HLMain'
  s.version          = '1.0.0'
  s.summary          = 'iOS开发基础框架'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    iOS开发基础框架 包含TabbarController 和 NavController  并且自定义导航栏滑动返回是全屏返回 通过导航栏分类可以实现一行代码设置导航栏的透明度
                       DESC

  s.homepage         = 'https://github.com/DargonLee/HLMain'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DargonLee' => '2461414445@qq.com' }
  s.source           = { :git => 'https://DargonLee/HLMain.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HLMain/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HLMain' => ['HLMain/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
