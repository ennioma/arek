[![N|Solid](https://github.com/ennioma/arek/blob/master/arek/Assets/arek.png?raw=true)](https://github.com/ennioma/arek/blob/master/arek/Assets/arek.png?raw=true)

![Platform Version](https://cocoapod-badges.herokuapp.com/p/arek/badge.png)
![Pod Version](https://cocoapod-badges.herokuapp.com/v/arek/0.0.6/badge.png)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![License](https://cocoapod-badges.herokuapp.com/l/arek/badge.png)
[![Swift Version](https://img.shields.io/badge/Swift-3.0.x-orange.svg)]()

AREK is a clean and easy to use wrapper over any kind of iOS permission.

* show a native popup used to avoid to burn the possibility to ask to iOS the *real* permission
* show a popup to invite the user to re-enable the permission if it has been denied
* manage through an easy configuration how many times to ask the user to re-enable the permission (Only once, every hour, once a day, weekly, always😷)

🚨 AREK is a **Swift 3** and **XCode 8** compatible project🚨

# Implemented permissions

- [x] Camera
- [x] Bluetooth 
- [x] CloudKit
- [x] Contacts
- [x] Events (Calendar)
- [x] Health
- [x] Location (Always)
- [x] Location (When in use)
- [x] Media Library
- [x] Microphone
- [x] Motion
- [x] Notifications
- [x] Photo
- [x] Reminders
- [x] Speech Recognizer 

# How to use AREK
## Check permission status
```swift
    let permission = ArekPhoto()

    permission.status { (status) in
        switch status {
        case .Authorized:
            print("! ✅ !")
        case .Denied:
            print("! ⛔️ !" )
        case .NotDetermined:
            print("! 🤔 !" )
        }
    }
```
## Request permission
```swift
    let permission = ArekEvent()

    permission.manage { (status) in
        switch status {
        case .Authorized:
            symbol = "✅"
        case .Denied:
            symbol = "⛔️"
        case .NotDetermined:
            symbol = "🤔"
        }
    }        
```

# Permission Configuration
Each permission type included in AREK is configurable through the *ArekConfiguration* struct. Each permission has a default configuration, so if you
are happy with the basic configuration you don't have to take care about how it works behind the scenes.

An *ArekConfiguration* is made up by:

> **frequency**: ArekPermissionFrequency (.Always, .EveryHour, .OnceADay, .OnceAWeek, .JustOnce)
This frequency value is related to how often you want to the user to re-enable a permission if that one has been disallowed.

> Set by default to **.OnceADay**


----------

>**presentInitialPopup**: Bool
This is an initial popup used to ask **kindly** to the user to allow a permission. This is useful to avoid burning the possibility to show the system popup.

>Set by default to **true**

----------
>**presentReEnablePopup**: Bool
This is the popup used to **kindly** to the user to re-enable that permission. The *frequency* value is related to this popup.

>Set by defaul to **true**

# How to install AREK
## CocoaPods
Add AREK to your Podfile 

```ruby
use_frameworks!
target 'MyTarget' do
    pod 'arek', '~> 1.0.0'
end
```

```bash
$ pod install
```

## Carthage

```ruby
github "ennioma/arek" ~> 1.0.0
```

## Swift Package Manager
```ruby
import PackageDescription

let package = Package(
  name: "YourApp",
  dependencies: [
    .Package(url: "https://github.com/ennioma/arek.git", versionMajor: 1, minor: 0)
  ]
)
```

## Add AREK source code to your project
Add [https://github.com/ennioma/arek/tree/master/arek/arek/Arek](https://github.com/ennioma/arek/tree/master/arek/Classes) folder to your project.

🙏 Take care about adding the ArekHealth class to your project. It includes HealthKit in your project, so if you do this without using HealthKit, your app will be rejected during the AppStore review.

## Contribute
Contributions are welcome 🙌  If you'd like to improve this projects I've shared with the community, just open an issue or raise a PR.

For any information or request feel free to contact me on twitter (@ennioma).

## License
AREK is available under the MIT license. See the LICENSE file for more info.

# TODO:
- [] restore tests to every permission type  
- [] Localize internal messages

