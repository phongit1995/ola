Pod::Spec.new do |s|
  s.name         = 'OlaAppLock'
  s.version      = '1.0.0'
  s.summary      = 'Xac thuc sinh trac hoc (Face ID / Touch ID) cho khoa ung dung Ola'
  s.homepage     = 'https://olachat.net'
  s.license      = { :type => 'MIT' }
  s.author       = { 'ola' => 'dev@olachat.net' }
  s.platforms    = { :ios => '15.1' }
  s.source       = { :path => '.' }
  s.source_files = '*.{h,mm}'
  s.frameworks   = 'LocalAuthentication'
  s.pod_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++20',
  }

  if respond_to?(:install_modules_dependencies, true)
    install_modules_dependencies(s)
  else
    s.dependency 'React-Core'
  end
end
