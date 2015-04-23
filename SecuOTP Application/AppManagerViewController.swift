//
//  AppManagerViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/26/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit
import CoreData

class AppManagerViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate {
    @IBOutlet var tableViewManager: UITableView!
    
    var site: [Site] = [Site]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        site = [Site]()
        
        let siteList: SiteEntity = SiteEntity()
        let data: [Site] = siteList.fetch()
        
        for i: Site in data{
            if i.siteName != nil{
                site.append(i)
            }
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.site.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var tableViewCell: CustomManagerTableCell? = self.tableView.dequeueReusableCellWithIdentifier("Cell") as? CustomManagerTableCell
        
        if tableViewCell == nil {
            tableViewCell = CustomManagerTableCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        //Add Utility Button
        var rightUtilityButtons: NSMutableArray = NSMutableArray()
        let utilityButtonColor: UIColor = UIColor(red: 192.0/255, green: 57.0/255, blue: 43.0/255, alpha: 1)
        rightUtilityButtons.sw_addUtilityButtonWithColor(utilityButtonColor, title: "Delete")
        
        tableViewCell?.rightUtilityButtons = rightUtilityButtons as [AnyObject]
        tableViewCell?.delegate = self
        
        var label: UILabel = tableViewCell?.viewWithTag(1) as! UILabel
        var wallpaper: UIImageView = tableViewCell?.viewWithTag(2) as! UIImageView
        label.text = site[indexPath.row].siteName! as String
        if site[indexPath.row].siteImage != nil {
            wallpaper.image = site[indexPath.row].siteImage
        }
        
        return tableViewCell! as CustomManagerTableCell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("AppManagerToOTP", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AppManagerToOTP" {
            let viewController: OTPViewController = segue.destinationViewController as! OTPViewController
            let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
            viewController.site = site[indexPath.row]
            
        }
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerRightUtilityButtonWithIndex index: Int) {
        if index == 0 {
            let appName: UILabel = cell.viewWithTag(1) as! UILabel
            let alert: UIAlertController = UIAlertController(title: "Warning", message: "Are you sure you want to remove \(appName.text!).", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in
                let pinAlert: UIAlertController = UIAlertController(title: "Verify Identity", message: "Please enter your PIN code", preferredStyle: UIAlertControllerStyle.Alert)
                let submitButton: UIAlertAction = UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in
                    let config: ConfigEntity = ConfigEntity()
                    let object: NSMutableArray = config.getValueFromKey("Password")
                    let pinField: UITextField = pinAlert.textFields![0] as! UITextField
                    
                    if pinField.text! == object[0] as! String {
                        let alert: UIAlertView = UIAlertView(title: "Good", message: "Good", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                    } else {
                        let alert: UIAlertView = UIAlertView(title: "Can't remove Application", message: "Incorrect PIN number", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                    }
                })
                
                pinAlert.addTextFieldWithConfigurationHandler({(textField: UITextField!) -> Void in
                    textField.placeholder = "PIN Code"
                    textField.secureTextEntry = true
                    textField.keyboardType = UIKeyboardType.NumberPad
                })
                
                pinAlert.addAction(submitButton)
                
                self.presentViewController(pinAlert, animated: true, completion: nil)
            })
            alert.addAction(okButton)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
