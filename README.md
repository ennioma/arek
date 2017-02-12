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
        case .authorized:
            print("! ✅ !")
        case .denied:
            print("! ⛔️ !" )
        case .notDetermined:
            print("! 🤔 !" )
        case .notAvailable:
            print("! 🚫 !" )
        }
    }
```
## Request a permission
```swift
    let permission = ArekEvent()

    permission.manage { (status) in
        switch status {
        case .authorized:
            symbol = "✅"
        case .denied:
            symbol = "⛔️"
        case .notDetermined:
            symbol = "🤔"
        case .notAvailable:
            return "🚫"
        }
    }        
```

# Permission Configuration
Each permission type included in `AREK` is configurable through the `ArekConfiguration` struct. Each permission has a default configuration, so if you are happy with the basic configuration you don't have to care about how it works behind the scenes.

An `ArekConfiguration` is made up by:

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

# Configure the initial and the re-enable popup: `ArekPopupData`
`ArekPopupData` is the struct used to configure both the pre-permission popup and the re-enable popup. These popups are instances of the amazing [PMAlertController](https://github.com/Codeido/PMAlertController) by [Codeido](http://www.codeido.com/).

The configuration is the following:
```ruby
public struct ArekPopupData {
    var title: String!
    var message: String!
    var image: String!

    public init(title: String = "", message: String = "", image: String = "") {
        self.title = title
        self.message = message
        self.image = image
    }
}
```

The default configuration for `ArekContacts` is
```ruby
public init() {
        super.init(initialPopupData: ArekPopupData(title: "Access Contacts", message: "\(Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String) needs to access Contacs, do you want to proceed?", image: "arek_contacts_image"),
                   reEnablePopupData: ArekPopupData(title: "Access Contacts", message: "Please re-enable the access to the Contacts", image: "arek_contacts_image"))
    }
```
and the generated popup is the following
[![N|Solid](https://github.com/ennioma/arek/blob/master/arek/Assets/arek_contacts.png?raw=true)](https://github.com/ennioma/arek/blob/master/arek/Assets/arek_contacts.png?raw=true)

The initial and re-enable popup are based on the following conventions:

| Permission      | Initial Title   | Initial Message | Re-Enable Title | Re-Enable Message | Image |
| :-------------: | :-------------: | :-------------: | :-------------: | :---------------: | :-------------: |
| Camera      | ArekCamera_initial_title | ArekCamera_initial_message | ArekCamera_reenable_title | ArekCamera_reenable_message | ArekCamera_image |
| CloudKit      | ArekCloudKit_initial_title | ArekCloudKit_initial_message | ArekCloudKit_reenable_title | ArekCloudKit_reenable_message | ArekCloudKit_image |
| Contacts      | ArekContacts_initial_title | ArekContacts_initial_message | ArekContacts_reenable_title | ArekContacts_reenable_message | ArekContacts_image |
| Events      | ArekEvents_initial_title | ArekEvents_initial_message | ArekEvents_reenable_title | ArekEvents_reenable_message | ArekEvents_image |
| HealthKit      | ArekHealth_initial_title | ArekHealth_initial_message | ArekHealth_reenable_title | ArekHealth_reenable_message | ArekHealth_image |
| Media Library  | ArekMediaLibrary_initial_title | ArekMediaLibrary_initial_message | ArekMediaLibrary_reenable_title | ArekMediaLibrary_reenable_message | ArekMediaLibrary_image |
| Microphone  | ArekMicrophone_initial_title | ArekMicrophone_initial_message | ArekMicrophone_reenable_title | ArekMicrophone_reenable_message | ArekMicrophone_image |
| Motion  | ArekMotion_initial_title | ArekMotion_initial_message | ArekMotion_reenable_title | ArekMotion_reenable_message | ArekMotion_image |
| Notifications  | ArekNotifications_initial_title | ArekNotifications_initial_message | ArekNotifications_reenable_title | ArekNotifications_reenable_message | ArekNotifications_image |
| Photo Library  | ArekPhoto_initial_title | ArekPhoto_initial_message | ArekPhoto_reenable_title | ArekPhoto_reenable_message | ArekPhoto_image |
| Reminders  | ArekReminders_initial_title | ArekReminders_initial_message | ArekReminders_reenable_title | ArekReminders_reenable_message | ArekReminders_image |
| Speech Recognizer  | ArekSpeechRecognizer_initial_title | ArekSpeechRecognizer_initial_message | ArekSpeechRecognizer_reenable_title | ArekSpeechRecognizer_reenable_message | ArekSpeechRecognizer_image |
| Bluetooth  | ArekBluetooth_initial_title | ArekBluetooth_initial_message | ArekBluetooth_reenable_title | ArekBluetooth_reenable_message | ArekBluetooth_image |
| Location  | ArekBaseLocation_initial_title | ArekBaseLocation_initial_message | ArekBaseLocation_reenable_title | ArekBaseLocation_reenable_message | ArekBaseLocation_image |

# How to install AREK
## CocoaPods
Add AREK to your Podfile

```ruby
use_frameworks!
target 'MyTarget' do
    pod 'arek', '~> 1.2.0'
end
```

```bash
$ pod install
```

## Carthage
🚫 Arek `1.2.0` is not supported through Carthage! 🚫

```ruby
github "ennioma/arek" ~> 1.1.0
```

## Swift Package Manager
🚫 Arek `1.2.0` is not supported through Swift Package Manager! 🚫

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

## TODO
- [] Provide a way to inject a custom PMAlertController in a permission
- [] Provide the possibility to choose between PMAlertController and a common UIAlertController
- [] Update the Swift Package Manager installation

## License
AREK is available under the MIT license. See the LICENSE file for more info.

# CREDITS:
Icones provided by `Freepik` and `Vectors Market` from `Flaticon`
