//
//  CreatePasswordController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/12/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//
import CryptoSwift
import UIKit

class GettingStartedViewController: UIViewController {
    // Outlet Only
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    // Auto Layout Programming only
    @IBOutlet weak var headLabel: UILabel!
    
    // Other Variable & Constant
    let plistWriter : PlistStream = PlistStream()
    
    // When this view controller loading
    override func viewDidLoad() {
        super.viewDidLoad()

        // Getting user Hardware Height
        let height = self.view.bounds.height
        
        // Layout Constraint
        let topHeadLabelConstraint : NSLayoutConstraint = NSLayoutConstraint(
            item: headLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1,
            constant: height * 0.2)
        let topPasswordFieldConstraint : NSLayoutConstraint = NSLayoutConstraint(
            item: passwordField,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: headLabel,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1,
            constant: height * 0.2)
        
        // Add Constraint to View Controller
        self.view.addConstraint(topHeadLabelConstraint)
        self.view.addConstraint(topPasswordFieldConstraint)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    // When user tapped Submit Button
    @IBAction func createPassword(sender: AnyObject) {
        // Get password form text Field
        var password : String = passwordField.text
        
        // Write Plist when key is "Password"
        plistWriter.setPlistValue(Key: "Password", Value: password.sha512()!)
        
        // Write Plist when key is "First Time"
        plistWriter.setPlistValue(Key: "First Time", Value: "false")
        
        // Show Dialog
        let dialog : UIAlertView = UIAlertView(
            title: "Create Password Complete",
            message: "Getting Started has completed",
            delegate: nil,
            cancelButtonTitle: "OK")
        dialog.show()
        
        // Segue to App Manager
        self.performSegueWithIdentifier("GettingStartedToAppManager", sender: self)
    }
}
