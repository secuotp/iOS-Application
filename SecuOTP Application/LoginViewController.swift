//
//  ViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 1/14/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    // Outlet Only
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    // Auto Layout Programming only
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var lockview: UIImageView!

    // Other Variable & Constant
    let plistIO : PlistStream = PlistStream()
    
    // When this view controller loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Getting user Hardware Height
        let height = self.view.bounds.height
            
        // Layout Constraint
        let topLogoConstraint : NSLayoutConstraint = NSLayoutConstraint(
            item: logoView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: viewContainer,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1,
            constant: height * 0.2)
        let topLockViewConstraint : NSLayoutConstraint = NSLayoutConstraint(
            item: lockview,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: logoView,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1,
            constant: height * 0.15)
        
        // Add Constraint to View Controller
        self.view.addConstraint(topLogoConstraint)
        self.view.addConstraint(topLockViewConstraint)
        
        
    }
    
    // When This view controller Appear
    override func viewDidAppear(animated: Bool) {
        // Check if this Application open for the first time
        if(plistIO.getPlistValue(Key: "First Time") == "true"){
            // Segue to Getting Started View Controller
            self.performSegueWithIdentifier("LoginToCreatePassword", sender: self)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // When user tapped Submit Button
    @IBAction func sendPassword(sender: AnyObject) {
        var password = passwordField.text
        var passwordSHA512 : NSString = password.sha512()!
        
        if(plistIO.getPlistValue(Key: "Password") == passwordSHA512){
            self.performSegueWithIdentifier("LoginToAppManager", sender: self)
        } else {
            let dialog : UIAlertView = UIAlertView(title: "Error",
                message: "Enter invalid Password",
                delegate: nil,
                cancelButtonTitle: "OK")
            dialog.show()
            passwordField.text = ""
        }
    }
}

