Pod::Spec.new do |s|
  s.name             = 'arek'
  s.version          = '0.0.4'
  s.summary          = 'AREK is a clean and easy to use wrapper over any kind of iOS permission.'
  s.homepage         = 'https://github.com/ennioma/arek'
  s.license          = { :type => 'unlicense'}
  s.author           = { 'Ennio Masi' => 'ennio.masi@gmail.com' }
  s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/arek.git', :tag => s.version.to_s }
  s.social_media_url   = "https://twitter.com/ennioma"
  s.ios.deployment_target = '9.0'
  s.source_files = 'arek/Classes/**/*', 'arek/Classes/Core/**/*', 'arek/Classes/Permissions/**/*'
end
