#
#  Be sure to run `pod spec lint TencentOpenAPI.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "TencentOpenAPI"
  s.version      = "3.2.3"
  s.summary      = "iOS版腾讯开放平台SDK"

  s.description  = <<-DESC
                    A short description of TencentOpenAPI.
                   DESC

  s.homepage     = "http://open.qq.com"
  s.license      = "MIT"

  s.author       = { "WangTao" => "wangtao@yupaopao.cn" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "http://ios-repo.oss-cn-shanghai.aliyuncs.com/man/1.0.7/man.zip", :tag => "#{s.version}" }

  s.resource = "TencentOpenApi_IOS_Bundle.bundle"
  s.ios.vendored_frameworks = "TencentOpenAPI.framework"
  s.framework = "Security", "SystemConfiguration", "CoreTelephony", "CoreGraphics"
  s.libraries = "iconv", "z", "c++", "sqlite3"

  s.requires_arc = true
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

end