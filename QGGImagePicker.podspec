Pod::Spec.new do |s|
  s.name             = "QGGImagePicker"
  s.version          = "0.0.1"
  s.license          = 'MIT'
  s.summary          = "A Image Picker Lib."
  s.description      = <<-DESC
                       A Image Picker like WeChat

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/infiniteQin"

  s.author           = { "qgg" => "1069130814@qq.com" }
  s.source           = { :git => "https://github.com/infiniteQin/QGGImagePicker.git", :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/infiniteQin'

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.public_header_files = 'Pods/Headers/Public/Masonry/*.h'
  s.source_files = 'Pods/Masonry/**/*.{h,m}','QGGImagePicker/QGGImagePicker/*.{h,m}','QGGImagePicker/QGGImagePicker/**/*.{h,m}'
  s.resources = 'QGGImagePicker/Assets.xcassets/**/*.png'
  s.frameworks = 'UIKit','AssetsLibrary'
  s.dependency 'Masonry', '~> 0.6.3'
end
