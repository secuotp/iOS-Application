//
//  CreatePasswordViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/25/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class CreatePasswordViewController: UIViewController {

    // Outlet
    @IBOutlet weak var dot1: UILabel!
    @IBOutlet weak var dot2: UILabel!
    @IBOutlet weak var dot3: UILabel!
    @IBOutlet weak var dot4: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textBanner: UILabel!
    
    // Parameter
    var pin : NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let topDotViewConstraint : NSLayoutConstraint = NSLayoutConstraint(item: textBanner, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: self.view.bounds.height * 0.2)
        
        self.view.addConstraint(topDotViewConstraint)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        // Open Keyboard
        textField.becomeFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CreatePasswordToConfirmPassword" {
            let confirmViewController: ConfirmPasswordViewController = segue.destinationViewController as ConfirmPasswordViewController
            confirmViewController.password = pin
            
            pin = nil
            textField.text = ""
            
            dot1.text = "-"
            dot2.text = "-"
            dot3.text = "-"
            dot4.text = "-"
        }
    }
    
    // When Edit Changed
    @IBAction func whenKeyboardTap(sender: AnyObject) {
        if countElements(textField.text) == 0 {
            dot1.text = "="
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
            
            textField.resignFirstResponder()
            
            let alert : UIAlertController = UIAlertController(title: "Create PIN", message: "Are you sure you use this PIN", preferredStyle: UIAlertControllerStyle.Alert)
            let yes : UIAlertAction = UIAlertAction(
                title: "Yes",
                style: UIAlertActionStyle.Default,
                handler: { action in
                    self.pin = self.textField.text!
                    self.performSegueWithIdentifier("CreatePasswordToConfirmPassword", sender: self)
                }
            )
            let no : UIAlertAction = UIAlertAction(
                title: "No",
                style: UIAlertActionStyle.Cancel,
                handler: { action in
                    self.textField.text = ""
                    self.dot1.text = "-"
                    self.dot2.text = "-"
                    self.dot3.text = "-"
                    self.dot4.text = "-"
                }
            )
            
            alert.addAction(yes)
            alert.addAction(no)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
