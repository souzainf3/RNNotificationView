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
    static let titleFont = UIFont.boldSystemFont(ofSize: 14)
    static let subtitleFont = UIFont.systemFont(ofSize: 13)
    
    static let animationDuration: TimeInterval = 0.3 // second(s)
    static let exhibitionDuration: TimeInterval = 5.0 // second(s)

}

internal struct NotificationLayout {
    static let height: CGFloat = 64.0
    static var width: CGFloat { return UIScreen.main.bounds.size.width }

    static var labelTitleHeight: CGFloat = 26
    static var labelMessageHeight: CGFloat = 35
    static var dragViewHeight: CGFloat = 3

    static let iconSize = CGSize(width: 22, height: 22)

    static let imageBorder: CGFloat = 15
    static let textBorder: CGFloat = 10
}
