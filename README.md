[![N|Solid](https://github.com/ennioma/arek/blob/master/resources/arek.png?raw=true)](https://github.com/ennioma/arek/blob/master/resources/arek.png?raw=true)

AREK is a clean and easy to use wrapper over any kind of iOS permission.

* show a native popup used to avoid to burn the possibility to ask to iOS the *real* permission
* show a popup to invite the user to re-enable the permission if it has been denied
* manage through an easy configuration how many times to ask the user to re-enable the permission (Only once, every hour, once a day, weekly, always😷)

🚨 AREK is a **Swift 3** and **XCode 8** compatible project🚨

# Implemented permissions
* Camera
* Contacts
* Events (Calendar)
* Health
* Location (Always)
* Location (When in use)
* Microphone
* Notifications
* Photo
* Reminders

# How to use AREK
## Check permission status
```swift
    let permission = EMPhoto()

    permission.status { (status) in
        switch status {
        case .Authorized:
            print("Yoah! ✅")
        case .Denied:
            print("! ⛔️ !" )
        case .NotDetermined:
            print("! 🤔 !" )
        }
    } 
```
## Request permission
```swift
    let permission = EMEvent()

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
You could add to your Podfile the line

>pod 'arek', '~> 0.0.4'

## Add AREK source code to your project
Add [https://github.com/ennioma/arek/tree/master/arek/arek/Arek](https://github.com/ennioma/arek/tree/master/arek/arek/Arek) folder to your project.

🙏 Take care about adding the ArekHealth class to your project. It includes HealthKit in your project, so if you do this without using HealthKit, your app will be rejected during the AppStore review.
 
# TODO:
* split podfile.spec in submodules to let the devs to add only the desired permissions
* add support to carthage
* add tests to every permission type  
