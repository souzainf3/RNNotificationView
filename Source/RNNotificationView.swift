//
//  RNNotificationView.swift
//
//  Created by Romilson Nunes on 21/10/16.
//
//

import UIKit

public class RNNotificationView: UIToolbar {
    
    // MARK: - Properties
//    public static var sharedNotification = NotificationView()

    public var titleFont = Notification.titleFont {
        didSet {
            titleLabel.font = titleFont
        }
    }
    public var titleTextColor = UIColor.whiteColor() {
        didSet {
            titleLabel.textColor = titleTextColor
        }
    }
    public var subtitleFont = Notification.subtitleFont {
        didSet {
            subtitleLabel.font = subtitleFont
        }
    }
    public var subtitleTextColor = UIColor.whiteColor() {
        didSet {
            subtitleLabel.textColor = subtitleTextColor
        }
    }
    public var duration: NSTimeInterval = 2.5
    
    public private(set) var isAnimating = false
    public private(set) var title: String?
    public private(set) var subtitle: String?
//    public private(set) var accessoryType: NotificationViewAccessoryType = .None
    
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        return iconImageView
    }()
    private lazy var titleLabel: UILabel = { [unowned self] in
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textAlignment = .Left
        titleLabel.font = self.titleFont
        titleLabel.textColor = self.titleTextColor
        return titleLabel
        }()
    private lazy var subtitleLabel: UILabel = { [unowned self] in
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.backgroundColor = UIColor.clearColor()
        subtitleLabel.textAlignment = .Left
        subtitleLabel.font = self.subtitleFont
        subtitleLabel.textColor = self.subtitleTextColor
        return subtitleLabel
        }()
    
    
   
    // MARK: - Initialization
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: NotificationLayout.notificationWidth, height: NotificationLayout.notificationHeight))
        
        startNotificationObservers()
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        setupFrame()
    }
    
    
    // MARK: - Observers
    
    private func startNotificationObservers() {
        /// Enable orientation tracking
        if !UIDevice.currentDevice().generatesDeviceOrientationNotifications {
            UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        }
        
        /// Add Orientation notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RNNotificationView.orientationStatusDidChange(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
    }
    
    // MARK: - Orientation Observer
    
    @objc private func orientationStatusDidChange(notification: NSNotification) {
        setupUI()
    }
    
    
    // MARK: - Setups
    
    private func setupFrame() {
        
        var frame = self.frame
        frame.size.width = NotificationLayout.notificationWidth
        self.frame = frame
    }

    
    private func setupUI() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        // iOS 7
//        self.barTintColor = nil;
//        self.translucent = YES;
//        self.barStyle = UIBarStyleBlack;
        
        self.tintColor = UIColor(red: 5, green: 31, blue: 75, alpha: 1)
        
        self.layer.zPosition = CGFloat.max
        self.backgroundColor = UIColor.clearColor()
        self.multipleTouchEnabled = false
        self.exclusiveTouch = true
        
        self.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleLeftMargin]

    }
    
}
