[![N|Solid](https://dl.dropboxusercontent.com/u/37783784/AREK/arek.png)](https://dl.dropboxusercontent.com/u/37783784/AREK/arek.png)

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
