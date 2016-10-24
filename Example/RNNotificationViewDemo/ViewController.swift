//
//  ViewController.swift
//  RNNotificationViewDemo
//
//  Created by Romilson Nunes on 21/10/16.
//  Copyright © 2016 Romilson Nunes. All rights reserved.
//

import UIKit
import RNNotificationView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Actions
    
    @IBAction func showAlertAction() {
        RNNotificationView.show(withImage: UIImage(named: "sambleIcon"),
                                title: "Zee Finance",
                                message: "Do not compromise more than 30% of their income on rent. Only consume essential.",
                                duration: 2,
                                onTap: {
                                    print("Did tap notification")
            })
        
        // Create Instance
//        let notification = RNNotificationView()
//        notification.titleFont = UIFont(name: "AvenirNext-Bold", size: 10)!
//        notification.titleTextColor = UIColor.blueColor()
//        notification.show(withImage: nil,
//                          title: "Title",
//                          message: "Message",
//                          onTap: {
//                            print("Did tap notification")
//        })
    }


}

