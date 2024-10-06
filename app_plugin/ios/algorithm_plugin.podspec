#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint algorithm_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'algorithm_plugin'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  s.swift_version = '5.0'

  s.source = { :path => '.' }
  s.source_files = 'Classes/**/*'

  s.preserve_paths = 'Frameworks/libalgorithm.a'
  s.vendored_libraries = 'Frameworks/libalgorithm.a'
  s.libraries = 'algorithm'

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'OTHER_LDFLAGS' => '-ObjC -force_load $(PODS_TARGET_SRCROOT)/Frameworks/libalgorithm.a'
  }
end
