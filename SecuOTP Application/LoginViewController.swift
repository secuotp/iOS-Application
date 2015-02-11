//
//  ViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 1/14/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    // Auto Layout Programming only
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var lockview: UIImageView!

    let plistIO : PlistStream = PlistStream()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if(plistIO.getPlistValue(Key: "First Time") == "true"){
            println("Get True")
        } else {
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
            
            self.view.addConstraint(topLogoConstraint)
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendPassword(sender: AnyObject) {
        var password:String = passwordField.text
        if(password == "1234"){
                    }else {
            var alertName : UIAlertView = UIAlertView(title: "Error", message: "Enter Invalid password", delegate: nil, cancelButtonTitle: "OK")
            alertName.show()
        }
    }
}
