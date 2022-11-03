#
# Be sure to run `pod lib lint GameBallSDK.podspec' to ensure this is a
# valid spec before submitting.

Pod::Spec.new do |s|
  
  #1
  s.platform = :ios
  s.name  = 'GameBallSDK'
  s.ios.deployment_target = '11.0'
  s.summary = 'Gameball SDK pod.'
  s.requires_arc = true

  # 2
  s.version    = '1.1.5'

  #3
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  #4
  s.author           = { 'Martin Sorsok' => 'martin.sorsok@gmail.com' }

  
  # 5 - Replace this URL with your own GitHub page's URL (from the address bar)
  s.homepage  = "https://github.com/MartinSorsok/GameBallSDK"
  
  
  #7
  s.source           = { :git => "https://github.com/MartinSorsok/GameBallSDK.git", :tag => s.version}
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'


  # 7
  s.framework = 'UIKit'
  s.static_framework = true
  s.dependency 'Firebase'
  s.dependency 'Firebase/Core'
  s.dependency 'Firebase/Messaging'
  s.dependency 'Firebase/Analytics'

  s.pod_target_xcconfig = {
    
    "ENABLE_BITCODE" => 'NO',
    
    "OTHER_LDFLAGS" => '$(inherited) -framework "GameBallSDK"'
  }
  
  
  #8
  s.source_files = 'GameBallSDK/**/*.{swift}'

  # 9
  s.resources = 'GameBallSDK/**/*.{png,jpeg,jpg,storyboard,xib,xcassets,strings,otf,ttf}', 'Resources/GoogleService-Info.plist'
  
  # 10
  s.swift_version = '4.2'
end
