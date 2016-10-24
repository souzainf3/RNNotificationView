//
//  Constants.swift
//  NotificationView
//
//  Created by Xin Hong on 16/5/9.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

internal let UILayoutPriorityNotificationPadding: Float = 999

internal struct Notification {
    static let titleFont = UIFont.boldSystemFontOfSize(14)
    static let subtitleFont = UIFont.systemFontOfSize(13)
    
    static let showAnimationDuration: NSTimeInterval = 0.3 // second(s)
    static let notificationDuration: NSTimeInterval  = 5.0 // second(s)

}

internal struct NotificationLayout {
    static let height: CGFloat = 64.0
    static var width: CGFloat { return UIScreen.mainScreen().bounds.size.width }

    
    static var labelMessageHeight: CGFloat = 35

    
    static let iconSize = CGSize(width: 36, height: 36)

    static let labelPadding: CGFloat = 45

    static let accessoryViewTrailing: CGFloat = 15
}
