Pod::Spec.new do |s|
  s.name             = 'arek'
  s.version          = '3.0.0'
  s.summary          = 'AREK is a clean and easy to use wrapper over any kind of iOS permission.'
  s.homepage         = 'https://github.com/ennioma/arek'
  s.license          = { :type => 'MIT', :file => 'LICENSE'}
  s.author           = { 'Ennio Masi' => 'ennio.masi@gmail.com' }
  s.source           = { :git => 'https://github.com/ennioma/arek.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ennioma'
  s.ios.deployment_target = '9.0'
  s.swift_version    = '4.0'
  s.source_files = 'code/Classes/**/*', 'code/Classes/Core/**/*', 'code/Classes/Permissions/**/*'
  s.exclude_files = 'Example/*'
  s.dependency 'PMAlertController', '3.4.0'

  s.subspec 'Core' do |ss|
    ss.source_files = 'code/Classes/Core/**/*.swift'
  end

  s.subspec 'Bluetooth' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/Bluetooth/*.swift'
    ss.frameworks = 'CoreBluetooth'
  end

  s.subspec 'Camera' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/ArekCamera.swift'
    ss.frameworks = 'AVFoundation'
  end

  s.subspec 'CloudKit' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/ArekCloudKit.swift'
    ss.frameworks = 'CloudKit'
  end

  s.subspec 'Contacts' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/ArekContacts.swift'
    ss.frameworks = 'AddressBook'
  end

  s.subspec 'Events' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/ArekEvents.swift'
    ss.frameworks = 'EventKit'
  end

  s.subspec 'Health' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/ArekHealth.swift'
    ss.frameworks = 'HealthKit'
  end

  s.subspec 'Location' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/Location/*.swift'
    ss.frameworks = 'CoreLocation'
  end

  s.subspec 'MediaLibrary' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/ArekMediaLibrary.swift'
    ss.frameworks = 'MediaPlayer'
  end

  s.subspec 'Microphone' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/ArekMicrophone.swift'
    ss.frameworks = 'AVFoundation'
  end

  s.subspec 'Motion' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/ArekMotion.swift'
    ss.frameworks = 'CoreMotion'
  end

  s.subspec 'Notifications' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/ArekNotifications.swift'
  end

  s.subspec 'Photos' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/ArekPhoto.swift'
    ss.frameworks = 'AssetsLibrary'
  end

  s.subspec 'Reminders' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/ArekReminders.swift'
    ss.frameworks = 'EventKit'
  end

  s.subspec 'SpeechRecognizer' do |ss|
    ss.dependency 'arek/Core'
    ss.source_files = 'code/Classes/Permissions/ArekSpeechRecognizer.swift'
    ss.frameworks = 'Speech'
    ss.ios.deployment_target = '9.0'
  end

end
