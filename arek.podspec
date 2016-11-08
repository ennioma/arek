Pod::Spec.new do |s|
  s.name         = "arek"
  s.version      = "0.0.1"
  s.summary      = "AREK is a clean and easy to use wrapper over any kind of iOS permission."
  s.homepage     = "https://github.com/ennioma/arek"
  s.license      = "unlicense"
  s.author       = "Ennio Masi"
  s.social_media_url   = "https://twitter.com/ennioma"
  
  s.ios.deployment_target = "10.0"
  s.source       = { :git => "https://github.com/ennioma/arek.git", :tag => s.version.to_s }

  s.source_files  = "arek/arek/Arek/**/*"
end
