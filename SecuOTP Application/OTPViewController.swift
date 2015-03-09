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
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        let timer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("timerBackground"), userInfo: nil, repeats: true)
    }

    func timerBackground() {
        progressBar.setProgress(progressBar.progress + 0.0033, animated: true)
        
        if progressBar.progress == 1 {
            progressBar.progress = 0.0
            var randomText: NSString = "\(arc4random_uniform(99999999 - 10000000) + 10000000)"
            otpCode.text = "\(randomText)"
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
