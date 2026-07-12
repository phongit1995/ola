Pod::Spec.new do |s|
  s.name         = 'TextRangeRects'
  s.version      = '1.0.0'
  s.summary      = 'Do toa do ky tu trong TextInput bang layout engine native'
  s.homepage     = 'https://olachat.net'
  s.license      = { :type => 'MIT' }
  s.author       = { 'ola' => 'dev@olachat.net' }
  s.platforms    = { :ios => '15.1' }
  s.source       = { :path => '.' }
  s.source_files = '*.{h,m}'
  s.dependency 'React-Core'
end
