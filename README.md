# RNNotificationView

Emulates the native Notification Banner UI for any alert.

Easy to use and customizable messages/notifications for iOS applications. ToatView with gestures.



[![](https://raw.githubusercontent.com/souzainf3/RNNotificationView/master/gif/rnnotificationview.gif)](https://raw.githubusercontent.com/souzainf3/RNNotificationView/master/gif/rnnotificationview.gif)

## Support

- [x] Swift 4.0 (version 3.x)
- [x] Swift 3.0 (version 2.x)
- [x] Swift 2.3 (version 1.1.0)
- [x] Swift 2.2 (version 1.0.0)

## Requirements

* iOS 7.0+ / Mac OS X 10.9+
* Xcode 9.0+, Swift 4.0

## Adding RNNotificationView to your project

#### Cocoapods

1. Add a pod entry for RNNotificationView to your Podfile `pod 'RNNotificationView'`
2. Install the pod(s) by running `pod install`.


## Using RNNotificationView

```swift

// Using Singleton
RNNotificationView.show(withImage: UIImage(named: "sambleIcon"),
title: "Title",
message: "Message",
duration: 2,
iconSize: CGSize(width: 22, height: 22), // Optional setup
onTap: {
print("Did tap notification")
}
)

// Creating instance
let notification = RNNotificationView()
// Customizations
notification.titleFont = UIFont(name: "AvenirNext-Bold", size: 10)!
notification.titleTextColor = UIColor.blueColor()
notification.iconSize = CGSize(width: 46, height: 46) // Optional setup
notification.show(withImage: nil,
title: "Title",
message: "Message",
onTap: {
print("Did tap notification")
})

```
## Customizing

You can create a `RNNotificationView` instance and configure this properties:

* The time that `RNNotificationView` stays in `UIView`. *Default: 5.0*
```swift
duration: NSTimeInterval
```

* Title Font. *Default: UIFont.boldSystemFontOfSize(14)*
```swift
titleFont: UIFont
```

* Subtitle Font. *Default: UIFont.systemFontOfSize(13)*
```swift
subtitleFont: UIFont
```

* Title text color. *Default: UIColor.whiteColor()*
```swift
titleTextColor: UIColor
```

* Subtitle text color. *Default: UIColor.whiteColor()*
```swift
subtitleTextColor: UIColor
```

* Icon size. *Default: NotificationLayout.iconSize*
```swift
iconSize: CGSize
```

