//
//  AppManagerViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/26/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class AppManagerViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableViewManager: UITableView!
    
    var item = ["SecuOTP", "Facebook", "Dropbox", "Final Fantasy XIV:ARR"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.item.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var tableViewCell: AnyObject? = self.tableView.dequeueReusableCellWithIdentifier("Cell")
        
        if tableViewCell == nil {
            tableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        var label: UILabel = tableViewCell?.viewWithTag(1) as UILabel
        label.text = item[indexPath.row]
        
        return tableViewCell as UITableViewCell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("AppManagerToOTP", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AppManagerToOTP" {
            let viewController: OTPViewController = segue.destinationViewController as OTPViewController
            let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
            viewController.appName = item[indexPath.row]
            
        }
    }
}
