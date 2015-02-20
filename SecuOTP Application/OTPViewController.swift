//
//  OTPViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/20/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {

    var titleName: NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(titleName == nil){
            titleName == "OTP"
        }
        
        self.navigationItem.title = titleName.capitalizedString
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
