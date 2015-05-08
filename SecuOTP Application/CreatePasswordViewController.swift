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
    var pin : NSString = ""
    var orangeColor: UIColor = UIColor(red: CGFloat(238.0/255), green: CGFloat(175.0/255), blue: CGFloat(72.0/255), alpha: 1)
    var greyColor: UIColor = UIColor(red: CGFloat(216.0/255), green: CGFloat(216.0/255), blue: CGFloat(216.0/255), alpha: 1)
    
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
    
    func passwordUpdate() -> Int {
        if count(textField.text) == 0 {
            dot1.textColor = greyColor
            dot2.textColor = greyColor
            dot3.textColor = greyColor
            dot4.textColor = greyColor
        } else if count(textField.text) == 1 {
            dot1.textColor = orangeColor
            dot2.textColor = greyColor
            dot3.textColor = greyColor
            dot4.textColor = greyColor
        } else if count(textField.text) == 2 {
            dot1.textColor = orangeColor
            dot2.textColor = orangeColor
            dot3.textColor = greyColor
            dot4.textColor = greyColor
        } else if count(textField.text) == 3 {
            dot1.textColor = orangeColor
            dot2.textColor = orangeColor
            dot3.textColor = orangeColor
            dot4.textColor = greyColor
        } else if count(textField.text) == 4 {
            dot1.textColor = orangeColor
            dot2.textColor = orangeColor
            dot3.textColor = orangeColor
            dot4.textColor = orangeColor
        }
        
        return count(textField.text)
    }
    
    // When Edit Changed
    @IBAction func whenKeyboardTap(sender: AnyObject) {
        if passwordUpdate() == 4 {
            let animation: CATransition = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.type = kCATransitionFade
            animation.duration = 0.75
            
            textBanner.layer.addAnimation(animation, forKey: "kCATransitionFade")
            
            textBanner.text = "Re-Enter PIN Number"
            
            if self.pin.length == 0 {
                self.pin = textField.text
                textField.text = ""
            } else {
                if self.pin == textField.text {
                    var config: ConfigEntity = ConfigEntity()
                    config.password = self.pin
                    config.save()
                    
                    let alert: UIAlertView = UIAlertView(title: "Completed", message: "Your PIN Number is saved", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                    self.performSegueWithIdentifier("CreatePasswordToManageApp", sender: self)
                } else {
                    textBanner.text = "Enter PIN Number"
                    textField.text = ""
                    self.pin = ""
                    
                    let alert: UIAlertView = UIAlertView(title: "Create PIN Number Failed", message: "Your PIN Number Mismatch", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
            }
            self.passwordUpdate()
        }
    }
}
