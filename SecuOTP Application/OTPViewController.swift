//
//  OTPViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/26/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var otpCode: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    var site: Site?
    var privateKey: String?
    var key: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = site?.siteName as? String
        let infoButton = UIBarButtonItem(image: UIImage(named: "InfoIcon"), style: UIBarButtonItemStyle.Done, target: self, action: Selector("rightNavButtonClick"))
        self.navigationItem.rightBarButtonItem = infoButton
        
        let topOtpViewConstraint: NSLayoutConstraint = NSLayoutConstraint(item: otpView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: self.view.bounds.height * 0.25)
        
        self.view.addConstraint(topOtpViewConstraint)
        
        let otpDict: NSDictionary = site!.calcOTP()
        var remaining: NSTimeInterval? = otpDict.objectForKey("remaining") as? NSTimeInterval
        var otp: String? = otpDict.objectForKey("otp") as? String
        
        progressBar.progress = Float(remaining! / 30)
        
        otpCode.text = otp!
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let timer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("timerBackground"), userInfo: nil, repeats: true)
    }

    func timerBackground() {
        progressBar.setProgress(progressBar.progress + 0.0033, animated: true)
        
        if progressBar.progress == 1 {
            progressBar.progress = 0.0
            
            let otpDict: NSDictionary = site!.calcOTP()
            
            var otp: String = otpDict.objectForKey("otp") as! String
            
            otpCode.text = otp
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "OtpToInfo" {
            var viewController: AppInfoViewController = segue.destinationViewController as! AppInfoViewController
            viewController.application = site
        }
    }
    
    func rightNavButtonClick() {
        performSegueWithIdentifier("OtpToInfo", sender: self)
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
