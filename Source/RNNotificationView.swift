//
//  RNNotificationView.swift
//
//  Created by Romilson Nunes on 21/10/16.
//
//

import UIKit

public class RNNotificationView: UIToolbar {
    
    // MARK: - Properties
    
    public static var sharedNotification = RNNotificationView()

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
    public var duration: NSTimeInterval = Notification.exhibitionDuration
    
    public private(set) var isAnimating = false
    public private(set) var isDragging = false
    
    private var dismissTimer: NSTimer? {
        didSet {
            if oldValue?.valid == true {
                oldValue?.invalidate()
            }
        }
    }
    
    private var tapAction: (() -> ())?

   
    /// Views
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 3
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var titleLabel: UILabel = { [unowned self] in
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textAlignment = .Left
        titleLabel.numberOfLines = 1
        titleLabel.font = self.titleFont
        titleLabel.textColor = self.titleTextColor
        return titleLabel
        }()
    private lazy var subtitleLabel: UILabel = { [unowned self] in
        let subtitleLabel = UILabel()
        subtitleLabel.backgroundColor = UIColor.clearColor()
        subtitleLabel.textAlignment = .Left
        subtitleLabel.numberOfLines = 2
        subtitleLabel.font = self.subtitleFont
        subtitleLabel.textColor = self.subtitleTextColor
        return subtitleLabel
        }()
    
    private lazy var dragView: UIView = { [unowned self] in
        let dragView = UIView()
        dragView.backgroundColor = UIColor(white: 1.0, alpha: 0.35)
        dragView.layer.cornerRadius = NotificationLayout.dragViewHeight / 2
        return dragView
        }()
    
    
    /// Frames
    
    private var imageViewFrame: CGRect {
        return CGRect(x: 15.0, y: 8.0, width: 20.0, height: 20.0)
    }
    
    private var dragViewFrame: CGRect {
        let width: CGFloat = 40
        return CGRect(x: (NotificationLayout.width - width) / 2 ,
                      y: NotificationLayout.height - 5,
                      width: width,
                      height: NotificationLayout.dragViewHeight)
    }
    

    private var titleLabelFrame: CGRect {
        if self.imageView.image == nil {
            return CGRect(x: 5.0, y: 3.0, width: NotificationLayout.width - 5.0, height: 26.0)
        }
        return CGRect(x: 45.0, y: 3.0, width: NotificationLayout.width - 45.0, height: 26.0)
    }
    
    private var messageLabelFrame: CGRect {
        if self.imageView.image == nil {
            return CGRect(x: 5, y: 25, width: NotificationLayout.width - 5, height: NotificationLayout.labelMessageHeight)
        }
        return CGRect(x: 45, y: 25, width: NotificationLayout.width - 45.0, height: NotificationLayout.labelMessageHeight)
    }

    
    
   
    // MARK: - Initialization
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: NotificationLayout.width, height: NotificationLayout.height))
        
        startNotificationObservers()
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Override Toolbar
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupFrames()
    }
    
    public override func intrinsicContentSize() -> CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: NotificationLayout.height)
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
    
    // TODO: - Use autolayout
    private func setupFrames() {
        
        var frame = self.frame
        frame.size.width = NotificationLayout.width
        self.frame = frame
        
        self.titleLabel.frame = self.titleLabelFrame
        self.imageView.frame = self.imageViewFrame
        self.subtitleLabel.frame = self.messageLabelFrame
        self.dragView.frame = self.dragViewFrame

        fixLabelMessageSize()
    }

    private func setupUI() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        // Bar style
        self.barTintColor = nil
        self.translucent = true
        self.barStyle = UIBarStyle.Black
        
        self.tintColor = UIColor(red: 5, green: 31, blue: 75, alpha: 1)
        
        self.layer.zPosition = CGFloat.max
        self.backgroundColor = UIColor.clearColor()
        self.multipleTouchEnabled = false
        self.exclusiveTouch = true
        
        self.frame = CGRect(x: 0, y: 0, width: NotificationLayout.width, height: NotificationLayout.height)
        self.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleLeftMargin]
        
        // Add subviews
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)
        self.addSubview(self.imageView)
        self.addSubview(self.dragView)
        
        
        // Gestures
        let tap = UITapGestureRecognizer(target: self, action: #selector(RNNotificationView.didTap(_:)))
        self.addGestureRecognizer(tap)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(RNNotificationView.didPan(_:)))
        self.addGestureRecognizer(pan)
        
        // Setup frames
        self.setupFrames()
    }
    
    
    // MARK: - Helper
    
    private func fixLabelMessageSize() {
        let size = self.subtitleLabel.sizeThatFits(CGSize(width: NotificationLayout.width - NotificationLayout.labelPadding, height: CGFloat.max))
        var frame = self.subtitleLabel.frame
        frame.size.height = size.height > NotificationLayout.labelMessageHeight ? NotificationLayout.labelMessageHeight : size.height
        self.subtitleLabel.frame = frame;
    }
    
    
    // MARK: - Actions
    
    @objc private func scheduledDismiss() {
        self.hide(completion: nil)
    }
    
    
    // MARK: - Tap gestures
    
    @objc private func didTap(gesture: UIGestureRecognizer) {
        self.userInteractionEnabled = false
        self.tapAction?()
        self.hide(completion: nil)
    }

    @objc private func didPan(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .Ended:
            self.isDragging = false
            if frame.origin.y < 0 || self.duration <= 0 {
                self.hide(completion: nil)
            }
            break
            
        case .Began:
            self.isDragging = true
            break

        case .Changed:
            
            guard let superview = self.superview else {
                return
            }
            
            guard let gestureView = gesture.view else {
                return
            }
            
            let translation = gesture.translationInView(superview)
            // Figure out where the user is trying to drag the view.
            let newCenter = CGPoint(x: superview.bounds.size.width / 2,
                                    y: gestureView.center.y + translation.y)
            
            // See if the new position is in bounds.
            if (newCenter.y >= (-1 * NotificationLayout.height / 2) && newCenter.y <= NotificationLayout.height / 2) {
                gestureView.center = newCenter
                gesture.setTranslation(CGPoint.zero, inView: superview)
            }

            break

        default:
            break
        }
        
    }
}



public extension RNNotificationView {
    
    // MARK: - Public Methods
    
    public func show(withImage image: UIImage?, title: String?, message: String?, duration: NSTimeInterval = Notification.exhibitionDuration, onTap: (() -> ())?) {
        
        /// Invalidate dismissTimer
        self.dismissTimer = nil
        
        // Tap action
        self.tapAction = onTap
        
        // Duration
        self.duration = duration
        
        /// Image
        self.imageView.image = image
        self.titleLabel.text = title
        self.subtitleLabel.text = message
        
        /// Prepare frame
        var frame = self.frame
        frame.origin.y = -frame.size.height
        self.frame = frame
        
        self.setupFrames()
        
        self.userInteractionEnabled = true
        self.isAnimating = true
        
        /// Add to window
        if let window = UIApplication.sharedApplication().delegate?.window {
            window?.windowLevel = UIWindowLevelStatusBar
            window?.addSubview(self)
        }
        
        /// Show animation
        UIView.animateWithDuration(Notification.animationDuration, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            var frame = self.frame
            frame.origin.y += frame.size.height
            self.frame = frame
            
        }) { (finished) in
            self.isAnimating = false
        }
        
        // Schedule to hide
        if self.duration > 0 {
            self.dismissTimer = NSTimer.scheduledTimerWithTimeInterval(Notification.animationDuration, target: self, selector: #selector(RNNotificationView.scheduledDismiss), userInfo: nil, repeats: false)
        }
        
        
    }
    
    public func hide(completion completion: (() -> ())?) {
        
        guard !self.isDragging else {
            self.dismissTimer = nil
            return
        }
        
        if self.superview == nil {
            isAnimating = false
            return
        }
        
        // Case are in animation of the hide
        if (isAnimating) {
            return
        }
        isAnimating = true
        
        // Invalidate timer auto close
        self.dismissTimer = nil
        
        /// Show animation
        UIView.animateWithDuration(Notification.animationDuration, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            var frame = self.frame
            frame.origin.y -= frame.size.height
            self.frame = frame
            
        }) { (finished) in
            
            self.removeFromSuperview()
            UIApplication.sharedApplication().delegate?.window??.windowLevel = UIWindowLevelNormal
            
            self.isAnimating = false
            
            completion?()
            
        }
    }

    
    // MARK: - Helpers
    
    public static func show(withImage image: UIImage?, title: String?, message: String?, duration: NSTimeInterval = Notification.exhibitionDuration, onTap: (() -> ())? = nil) {
        self.sharedNotification.show(withImage: image, title: title, message: message, onTap: onTap)
    }
    
    public static func hide(completion completion: (() -> ())? = nil) {
        self.sharedNotification.hide(completion: completion)
    }

}
