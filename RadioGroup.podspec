
Pod::Spec.new do |s|

  s.name         = "RadioGroup"
  s.version      = "1.4.2"
  s.summary      = "The missing iOS radio buttons group."

  s.homepage     = "https://github.com/yonat/RadioGroup"
  s.screenshots  = "https://raw.githubusercontent.com/yonat/RadioGroup/master/Screenshots/RadioGroup.png"

  s.license      = { :type => "MIT", :file => "LICENSE.txt" }

  s.author             = { "Yonat Sharon" => "yonat@ootips.org" }
  s.social_media_url   = "https://twitter.com/yonatsharon"

  s.swift_version = '4.2'
  s.swift_versions = ['4.2', '5.0']
  s.platform     = :ios, "11.0"
  s.requires_arc = true
  s.weak_framework = 'SwiftUI'

  s.source       = { :git => "https://github.com/yonat/RadioGroup.git", :tag => s.version }
  s.source_files  = "Sources/*.swift"

  s.dependency 'SweeterSwift'

  s.pod_target_xcconfig = { 'LD_RUNPATH_SEARCH_PATHS' => '$(FRAMEWORK_SEARCH_PATHS)' } # fix Interface Builder render error

end
