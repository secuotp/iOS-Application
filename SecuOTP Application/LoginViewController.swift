//
//  LogibViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/25/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var dot1: UILabel!
    @IBOutlet weak var dot2: UILabel!
    @IBOutlet weak var dot3: UILabel!
    @IBOutlet weak var dot4: UILabel!
    // Constraint Only
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let topLogoConstraint: NSLayoutConstraint = NSLayoutConstraint(
            item: logo,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1,
            constant: self.view.bounds.height * 0.15)
        
        self.view.addConstraint(topLogoConstraint)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        sleep(1)
        let config:ConfigEntity = ConfigEntity()
        
        var count = config.recordCount()
        if count - 1 == 0 {
            self.performSegueWithIdentifier("LoginToStart", sender: self)
        } else {
            textField.becomeFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func whenKeyboardTap(sender: AnyObject) {
        if countElements(textField.text) == 0 {
            dot1.text = "-"
            dot2.text = "-"
            dot3.text = "-"
            dot4.text = "-"
        } else if countElements(textField.text) == 1 {
            dot1.text = "•"
            dot2.text = "-"
            dot3.text = "-"
            dot4.text = "-"
        } else if countElements(textField.text) == 2 {
            dot1.text = "•"
            dot2.text = "•"
            dot3.text = "-"
            dot4.text = "-"
        } else if countElements(textField.text) == 3 {
            dot1.text = "•"
            dot2.text = "•"
            dot3.text = "•"
            dot4.text = "-"
        } else if countElements(textField.text) == 4 {
            dot1.text = "•"
            dot2.text = "•"
            dot3.text = "•"
            dot4.text = "•"
            
            let config: ConfigEntity = ConfigEntity()
            let data: NSMutableArray = config.getValueFromKey("password")
            
            println("Data: \(data[0] as NSString)")
            if (data[0] as NSString) == textField.text {
                self.performSegueWithIdentifier("LoginToManageApp", sender: self)
            } else {
                let alert: UIAlertView = UIAlertView(title: "Login Failed", message: "Your PIN is Incorrect", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                
                dot1.text = "-"
                dot2.text = "-"
                dot3.text = "-"
                dot4.text = "-"
                textField.text = ""
                
            }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    }
}
