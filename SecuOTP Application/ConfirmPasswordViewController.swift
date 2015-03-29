//
//  ConfirmPasswordViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/26/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class ConfirmPasswordViewController: UIViewController {

    @IBOutlet weak var dot1: UILabel!
    @IBOutlet weak var dot2: UILabel!
    @IBOutlet weak var dot3: UILabel!
    @IBOutlet weak var dot4: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    // Constraint Only
    @IBOutlet weak var textLabel: UILabel!
   
    // Parameter
    var password: NSString?
    var orangeColor: UIColor = UIColor(red: CGFloat(238.0/255), green: CGFloat(175.0/255), blue: CGFloat(72.0/255), alpha: 1)
    var greyColor: UIColor = UIColor(red: CGFloat(216.0/255), green: CGFloat(216.0/255), blue: CGFloat(216.0/255), alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let topLabelViewConstraint : NSLayoutConstraint = NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: self.view.bounds.height * 0.2)
        
        self.view.addConstraint(topLabelViewConstraint)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        textField.becomeFirstResponder()
    }

    @IBAction func whenKeyboardTap(sender: AnyObject) {
        if countElements(textField.text) == 0 {
            dot1.textColor = greyColor
            dot2.textColor = greyColor
            dot3.textColor = greyColor
            dot4.textColor = greyColor
        } else if countElements(textField.text) == 1 {
            dot1.textColor = orangeColor
            dot2.textColor = greyColor
            dot3.textColor = greyColor
            dot4.textColor = greyColor
        } else if countElements(textField.text) == 2 {
            dot1.textColor = orangeColor
            dot2.textColor = orangeColor
            dot3.textColor = greyColor
            dot4.textColor = greyColor
        } else if countElements(textField.text) == 3 {
            dot1.textColor = orangeColor
            dot2.textColor = orangeColor
            dot3.textColor = orangeColor
            dot4.textColor = greyColor
        } else if countElements(textField.text) == 4 {
            dot1.textColor = orangeColor
            dot2.textColor = orangeColor
            dot3.textColor = orangeColor
            dot4.textColor = orangeColor
            
            textField.resignFirstResponder()
            
            let alert : UIAlertController = UIAlertController(title: "Create PIN", message: "Are you sure you use this PIN", preferredStyle: UIAlertControllerStyle.ActionSheet)
            let yes : UIAlertAction = UIAlertAction(
                title: "Yes",
                style: UIAlertActionStyle.Default,
                handler: { action in
                    if self.password! == self.textField.text {
                        let config:ConfigEntity = ConfigEntity()
                        config.password = self.password
                        config.save()
                        
                        self.performSegueWithIdentifier("ConfirmPasswordToLogin", sender: self)
                    } else {
                        let errorAlert: UIAlertView = UIAlertView(title: "Create PIN Failed", message: "Your entered PIN is mismatched\nCreated Again", delegate: nil, cancelButtonTitle: "OK")
                        
                        errorAlert.show()
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
            )
            let no : UIAlertAction = UIAlertAction(
                title: "No",
                style: UIAlertActionStyle.Cancel,
                handler: { action in
                    self.textField.text = ""
                    self.dot1.textColor = self.greyColor
                    self.dot2.textColor = self.greyColor
                    self.dot3.textColor = self.greyColor
                    self.dot4.textColor = self.greyColor
                }
            )
            
            alert.addAction(yes)
            alert.addAction(no)
            
            self.presentViewController(alert, animated: true, completion: nil)
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
