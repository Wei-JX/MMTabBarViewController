#
#  Be sure to run `pod spec lint HYBLoopScrollView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "MMTabBarViewController"
s.version      = "0.0.1"
s.summary      = "A short description of MMTabBarViewController."

s.description  = <<-DESC
A short description of MMTabBarViewController.
DESC

s.homepage     = "http://lijiachao@git.innotechx.com/scm/~lijiachao/test.git"
s.license      = "MIT"

s.author       = { "李佳超" => "lijiachao@yupaopao.cn" }
s.platform     = :ios, "8.0"
s.source       = { :git => "http://lijiachao@git.innotechx.com/scm/~lijiachao/test.git", :tag => "#{s.version}" }

s.source_files = "Classes", "Classes/*.{h,m}"
s.ios.public_header_files = "Framework/*.framework/Headers/*.h"
s.ios.vendored_frameworks = "Framework/*.framework"
s.requires_arc = true
s.resources = "Images/*.xcassets"
end
