
Pod::Spec.new do |s|

  s.name         = "RadioGroup"
  s.version      = "1.2.0"
  s.summary      = "The missing iOS radio buttons group."

  s.homepage     = "https://github.com/yonat/RadioGroup"
  s.screenshots  = "https://raw.githubusercontent.com/yonat/RadioGroup/master/Screenshots/RadioGroup.png"

  s.license      = { :type => "MIT", :file => "LICENSE.txt" }

  s.author             = { "Yonat Sharon" => "yonat@ootips.org" }
  s.social_media_url   = "http://twitter.com/yonatsharon"

  s.swift_version = '4.2'
  s.platform     = :ios, "9.0"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/yonat/RadioGroup.git", :tag => s.version }
  s.source_files  = "Sources/*.swift"

  s.dependency 'MiniLayout'

end
