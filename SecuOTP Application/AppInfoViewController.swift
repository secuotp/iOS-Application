//
//  AppInfoViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 4/24/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class AppInfoViewController: UITableViewController {
    var application: Site?
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var domain: UILabel!
    @IBOutlet weak var serial: UILabel!
    @IBOutlet weak var removal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Application Info"
        appName.text = application?.siteName as? String
        domain.text = application?.siteDomain as? String
        serial.text = application?.userSerial as? String
        removal.text = application?.userRemoval as? String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
