#
# Be sure to run `pod lib lint XKExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XKExtensions'
  s.version          = '1.0.17'
  s.summary          = 'Swift项目常用Extension'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'hhttps://github.com/kunhum/XKExtensions'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kenneth' => 'kunhum@163.com' }
  s.source           = { :git => 'https://github.com/kunhum/XKExtensions.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'

  # s.source_files = 'XKExtensions/Classes/**/*'
  
  s.subspec 'Common' do |ss|
    ss.dependency 'SwifterSwift'
    ss.dependency 'MJRefresh'
    ss.source_files = "XKExtensions/Classes/Common/**/*"
  end

  s.subspec 'RxSwift' do |ss|
    ss.dependency 'RxSwift'
    ss.dependency 'RxCocoa'
    ss.source_files = "XKExtensions/Classes/RxSwift/**/*"
  end

  s.subspec 'Constants' do |ss|
    ss.source_files = "XKExtensions/Classes/Constants/**/*"
  end
  
  s.subspec 'Network' do |ss|
    ss.dependency 'RxSwift'
    ss.dependency 'MJRefresh'
    ss.dependency 'XKNetwork'
    ss.source_files = "XKExtensions/Classes/Network/**/*"
  end

end
