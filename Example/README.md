This example shows how to create and manage permissions in two different ways:

Looking at the file `ArekCellVM` you can see that some permissions (i.e. [`ArekMediaLibrary`](https://github.com/ennioma/arek/blob/master/code/Classes/Permissions/ArekMediaLibrary.swift)) are instantiated as:

`ArekMediaLibrary(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)`

Where:
- configuration
- initialPopupData
- reEnablePopupData

are three structs that can be populated programmatically.

But if you take a look at 

```swift
static private func giveMeContacts() -> ArekPermissionProtocol {
    return ArekContacts()
}
```

You can notice that [`ArekContacts`](https://github.com/ennioma/arek/blob/master/code/Classes/Permissions/ArekContacts.swift) has been instantiated without any parameter.

In this case the parameters are read from any `Localizable.string` provided from your app, following this convention:

```swift
struct ArekLocalizationManager {
    var initialTitle: String = ""
    var initialMessage: String = ""
    var image: String = ""
    var reEnableTitle: String = ""
    var reEnableMessage: String = ""
    var allowButtonTitle: String = ""
    var denyButtonTitle: String = ""
    
    init(permission: String) {
        self.initialTitle = NSLocalizedString("\(permission)_initial_title", comment: "")
        self.initialMessage = NSLocalizedString("\(permission)_initial_message", comment: "")
        
        self.image = "\(permission)_image"
        
        self.reEnableTitle = NSLocalizedString("\(permission)_reenable_title", comment: "")
        self.reEnableMessage = NSLocalizedString("\(permission)_reenable_message", comment: "")

        self.allowButtonTitle = NSLocalizedString("\(permission)_allow_button_title", comment: "")
        self.denyButtonTitle = NSLocalizedString("\(permission)_deny_button_title", comment: "")
    }
}
```

The complete list of the identifiers that can be configured in the Localizable files is [here](https://github.com/ennioma/arek#localized-strings).