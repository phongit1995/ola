Pod::Spec.new do |s|
  s.name         = 'OlaRichText'
  s.version      = '1.0.0'
  s.summary      = 'Render text + emoji + smiley inline bang native TextKit cho chat Ola'
  s.homepage     = 'https://olachat.net'
  s.license      = { :type => 'MIT' }
  s.author       = { 'ola' => 'dev@olachat.net' }
  s.platforms    = { :ios => '15.1' }
  s.source       = { :path => '.' }
  s.source_files = '*.{h,mm}'
  s.pod_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++20',
  }

  if respond_to?(:install_modules_dependencies, true)
    install_modules_dependencies(s)
  else
    s.dependency 'React-Core'
  end
end
