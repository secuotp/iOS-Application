//
//  ViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 1/14/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendPassword(sender: AnyObject) {
        var password:String = passwordField.text
        if(password == "1234"){
            println("Good")
            
        }else {
            println("Not Good")
        }
    }
}

