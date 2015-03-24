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

    var appName: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = appName
        
        let topOtpViewConstraint: NSLayoutConstraint = NSLayoutConstraint(item: otpView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: self.view.bounds.height * 0.25)
        
        self.view.addConstraint(topOtpViewConstraint)
        
        var time: NSDate = NSDate()
        var newTime = time.reformatTime(0, minute: 0, second: 30)
        
        var remainingTime = abs(newTime.timeIntervalSince1970 - time.timeIntervalSince1970)
        println("\(remainingTime) Seconds left")
        progressBar.progress = Float(remainingTime / 30)
        
        var format: NSDateFormatter = NSDateFormatter()
        format.dateFormat = "YYYY-MM-dd HH:mm:ss"
        println("Time: \(format.stringFromDate(newTime))")
        var tmp = Int(newTime.timeIntervalSince1970) * 1000

        var key: String = "\(Int(tmp))"
        var data: String = appName!
        
        var otp: NSString = data.totp(key, digits: 8)
        
        otpCode.text = otp
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        let timer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("timerBackground"), userInfo: nil, repeats: true)
    }

    func timerBackground() {
        progressBar.setProgress(progressBar.progress + 0.0033, animated: true)
        
        if progressBar.progress == 1 {
            progressBar.progress = 0.0
            
            var time: NSDate = NSDate()
            time = time.reformatTime(0, minute: 0, second: 30)
            
            var format: NSDateFormatter = NSDateFormatter()
            format.dateFormat = "YYYY-MM-dd HH:mm:ss"
            println("Time: \(format.stringFromDate(time))")
            var tmp = Int(time.timeIntervalSince1970) * 1000
            
            var key: String = "\(Int(tmp))"
            var data: String = appName!
            
            var otp: NSString = data.totp(key, digits: 8)
            
            otpCode.text = otp

            
            otpCode.text = "\(otp)"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
