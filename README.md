<p align="center">
<img src="https://github.com/ennioma/arek/blob/master/code/Assets/arek.png" alt="AREK" width="295" height="54">
</p>
<br />

![Platform Version](https://cocoapod-badges.herokuapp.com/p/arek/badge.png)
![Pod Version](https://cocoapod-badges.herokuapp.com/v/arek/0.0.6/badge.png)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![License](https://cocoapod-badges.herokuapp.com/l/arek/badge.png)
[![Swift Version](https://img.shields.io/badge/Swift-3.0.x-orange.svg)]()

AREK is a clean and easy to use wrapper over any kind of iOS permission written in Swift.

Why AREK could help you building a better app is well described by Apple <a href="https://developer.apple.com/ios/human-interface-guidelines/interaction/requesting-permission/">here</a>:

```
Request personal data only when your app clearly needs it.
...
Explain why your app needs the information if it’s not obvious.
...
Request permission at launch only when necessary for your app to function.
...
```

Every goal could be easily reached using **AREK**.

* show a native popup used to avoid burning the possibility to ask to iOS the *real* permission
* show a popup to invite the user to re-enable the permission if it has been denied
* manage through an easy configuration how many times to ask the user to re-enable the permission (Only once, every hour, once a day, weekly, always😷)

🚨 AREK is a **Swift 4.2** and **Xcode 10** compatible project 🚨

Important!
- If you want to use it with **Xcode 10**, swift 4.2, point to the version [4.0.1](https://github.com/ennioma/arek/releases/tag/4.0.1)
- If you want to use it with **Xcode 9**, point to any prior version


## Build Status

| Branch | Status |
| ------------- | ------------- |
| Master | [![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=59a16154a7ae7b000183f1cf&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/59a16154a7ae7b000183f1cf/build/latest?branch=master) |
| Develop | [![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=59a16154a7ae7b000183f1cf&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/59a16154a7ae7b000183f1cf/build/latest?branch=develop) |

# Table of Contents
1. [Implemented permissions](#implementedPermissions)
2. [How to use AREK](#howTo)
3. [Permissions Configuration](#permissionsConfiguration)
4. [How to install AREK](#howToInstall)
5. [How to contribute](#contribute)
6. [TODO](#todo)
7. [License and Credits](#licenseCredits)

<a name="implementedPermissions"></a>
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
- [x] Siri
- [x] Speech Recognizer

<a name="howTo"></a>
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

<a name="permissionsConfiguration"></a>
# Permissions Configuration
## General configuration
Each permission type included in `AREK` is configurable through the `ArekConfiguration` struct. Each permission has a default configuration, so if you are happy with the basic configuration you don't have to care about how it works behind the scenes.

An `ArekConfiguration` is made up by:

> **frequency**: ArekPermissionFrequency (.Always, .EveryHour, .OnceADay, .OnceAWeek, .JustOnce)
This frequency value is related to how often you want to the user to re-enable a permission if that one has been disallowed.

> Set by default to **.OnceADay**

----------

> **presentInitialPopup**: Bool
This is an initial popup used to ask **kindly** to the user to allow a permission. This is useful to avoid burning the possibility to show the system popup.

>Set by default to **true**

----------

> **presentReEnablePopup**: Bool
This is the popup used to **kindly** to the user to re-enable that permission. The *frequency* value is related to this popup.

> Set by defaul to **true**

## Configure the initial and the re-enable popup: `ArekPopupData`
`ArekPopupData` is the struct used to configure both the pre-permission popup and the re-enable popup. These popups could be instances of the amazing [PMAlertController](https://github.com/Codeido/PMAlertController) by [Codeido](http://www.codeido.com/) or native iOS alerts.

The configuration is the following:
```ruby
public struct ArekPopupData {
    var title: String!
    var message: String!
    var image: String!
    var type: ArekPopupType!

    public init(title: String = "", message: String = "", image: String = "", type: ArekPopupType = .codeido) {
        self.title = title
        self.message = message
        self.image = image
        self.type = type
    }
}
```

This is an example of the `ArekContacts` pre-enable popup using `PMAlertController`:
<br />
<img src="https://github.com/ennioma/arek/blob/master/code/Assets/arek_contacts.png" width="150">

If you want to present a native `UIAlertController` set the type to `.native` otherwise if you want to setup a `PMAlertController` set the type to `.codeido`.

## Localized Strings
**AREK** by convention expects to find localized strings in your Localizable files in order to configure the UI.

In the following table there are the configurations for:
- Pre-permission popup title
- Pre-permission popup message
- Re-enable popup title
- Re-enable popup message
- Popup image for that permission
- Allow button title
- Deny button title

Messages related to the iOS native permission popup should be configured following the conventions described <a href="https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW1">here</a>.

| Permission      | Pre-permission Title   | Pre-permission Message | Re-Enable Title | Re-Enable Message | Image | Allow Button Title | Deny Button Title |
| :-------------: | :-------------: | :-------------: | :-------------: | :---------------: | :---: | :----------------: | :---------------: |
| Camera      | ArekCamera_initial_title | ArekCamera_initial_message | ArekCamera_reenable_title | ArekCamera_reenable_message | ArekCamera_image | ArekCamera_allow_button_title | ArekCamera_deny_button_title |
| CloudKit      | ArekCloudKit_initial_title | ArekCloudKit_initial_message | ArekCloudKit_reenable_title | ArekCloudKit_reenable_message | ArekCloudKit_image | ArekCloudKit_allow_button_title | ArekCloudKit_deny_button_title
| Contacts      | ArekContacts_initial_title | ArekContacts_initial_message | ArekContacts_reenable_title | ArekContacts_reenable_message | ArekContacts_image | ArekContacts_allow_button_title | ArekContacts_deny_button_title
| Events      | ArekEvents_initial_title | ArekEvents_initial_message | ArekEvents_reenable_title | ArekEvents_reenable_message | ArekEvents_image | ArekEvents_allow_button_title | ArekEvents_deny_button_title |
| HealthKit      | ArekHealth_initial_title | ArekHealth_initial_message | ArekHealth_reenable_title | ArekHealth_reenable_message | ArekHealth_image | ArekHealth_allow_button_title | ArekHealth_deny_button_title |
| Media Library  | ArekMediaLibrary_initial_title | ArekMediaLibrary_initial_message | ArekMediaLibrary_reenable_title | ArekMediaLibrary_reenable_message | ArekMediaLibrary_image | ArekMediaLibrary_allow_button_title | ArekMediaLibrary_deny_button_title |
| Microphone  | ArekMicrophone_initial_title | ArekMicrophone_initial_message | ArekMicrophone_reenable_title | ArekMicrophone_reenable_message | ArekMicrophone_image | ArekMicrophone_allow_button_title | ArekMicrophone_deny_button_title |
| Motion  | ArekMotion_initial_title | ArekMotion_initial_message | ArekMotion_reenable_title | ArekMotion_reenable_message | ArekMotion_image | ArekMotion_allow_button_title | ArekMotion_deny_button_title |
| Notifications  | ArekNotifications_initial_title | ArekNotifications_initial_message | ArekNotifications_reenable_title | ArekNotifications_reenable_message | ArekNotifications_image | ArekNotifications_allow_button_title | ArekNotifications_deny_button_title |
| Photo Library  | ArekPhoto_initial_title | ArekPhoto_initial_message | ArekPhoto_reenable_title | ArekPhoto_reenable_message | ArekPhoto_image | ArekPhoto_allow_button_title | ArekPhoto_deny_button_title |
| Reminders  | ArekReminders_initial_title | ArekReminders_initial_message | ArekReminders_reenable_title | ArekReminders_reenable_message | ArekReminders_image | ArekReminders_allow_button_title | ArekReminders_ deny_button_title|
| Siri  | ArekSiri_initial_title | ArekSiri_initial_message | ArekSiri_reenable_title | ArekSiri_reenable_message | ArekSiri_image | ArekSiri_allow_button_title | ArekSiri_deny_button_title |
| Speech Recognizer  | ArekSpeechRecognizer_initial_title | ArekSpeechRecognizer_initial_message | ArekSpeechRecognizer_reenable_title | ArekSpeechRecognizer_reenable_message | ArekSpeechRecognizer_image | ArekSpeechRecognizer_allow_button_title | ArekSpeechRecognizer_deny_button_title |
| Bluetooth  | ArekBluetooth_initial_title | ArekBluetooth_initial_message | ArekBluetooth_reenable_title | ArekBluetooth_reenable_message | ArekBluetooth_image | ArekBluetooth_allow_button_title | ArekBluetooth_deny_button_title |
| Location  | ArekBaseLocation_initial_title | ArekBaseLocation_initial_message | ArekBaseLocation_reenable_title | ArekBaseLocation_reenable_message | ArekBaseLocation_image | ArekBaseLocation_allow_button_title | ArekBaseLocation_deny_button_title |

<a name="howToInstall"></a>
# How to install AREK
## CocoaPods
Add AREK to your Podfile

```ruby
use_frameworks!
target 'MyTarget' do
    pod 'arek', '~> 2.0.2'
end
```

If you want to install just a specific permission, let's say `Bluetooth`, you have to specify:
```ruby
use_frameworks!
target 'MyTarget' do
    pod 'arek/Bluetooth', '~> 2.0.2'
end
```

```bash
$ pod install
```

## Carthage
```ruby
github "ennioma/arek" ~> "2.0.2"
```

Then on your application target *Build Phases* settings tab, add a "New Run Script Phase". Create a Run Script with the following content:

```ruby
/usr/local/bin/carthage copy-frameworks
```

and add the following paths under "Input Files":

```ruby
$(SRCROOT)/Carthage/Build/iOS/arek.framework
$(SRCROOT)/Carthage/Build/iOS/PMAlertController.framework
```

## Swift Package Manager
```ruby
import PackageDescription

let package = Package(
  name: "YourApp",
  dependencies: [
    .Package(url: "https://github.com/ennioma/arek.git", versionMajor: 2, minor: 0)
  ]
)
```

- Note that if you want to install a *Swift 3* version of Arek, the latest compatible version is the *1.7.0*.
- If you need to build it on Xcode 10, you have to point to the version `3.0.0`.

## Add AREK source code to your project
Add [https://github.com/ennioma/arek/tree/master/arek/arek/Arek](https://github.com/ennioma/arek/tree/master/arek/Classes) folder to your project.

🙏 Take care about adding the ArekHealth class to your project. It includes HealthKit in your project, so if you do this without using HealthKit, your app will be rejected during the AppStore review.

<a name="contribute"></a>
# How to contribute
Contributions are welcome 🙌  If you'd like to improve this projects I've shared with the community, just open an issue or raise a PR from the current develop branch.

For any information or request feel free to contact me on twitter (@ennioma).

<a name="todo"></a>
# TODO
- [] Provide a way to inject a custom PMAlertController in a permission
- [] Provide a way to inject the popup type when the `init()` is called on a permission
- [] Update the Swift Package Manager installation

<a name="licenseCredits"></a>
# License and Credits
## License:
AREK is available under the MIT license. See the LICENSE file for more info.

## Arek on the Web:
1. [This week in Swift - Natasha The Robot](https://swiftnews.curated.co/issues/113#libraries)
2. [iOS Dev Weekly - Dave Verwer](https://iosdevweekly.com/issues/281#code)

## Credits:
Icones provided by `Freepik` and `Vectors Market` from `Flaticon`
