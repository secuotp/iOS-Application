//
//  SettingViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/26/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit
import CoreData

class SettingViewController: UITableViewController, UITableViewDelegate {
    
    @IBOutlet weak var timeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = \self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        let path = NSBundle.mainBundle().pathForResource("Time", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        let timeDiff = dict?.objectForKey("time") as! Int
        timeLabel.text = "\(timeDiff) sec"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                timeSync()
            }
        } else {
            if indexPath.row == 0 {
                changePIN()
            } else {
                
            }
        }
    }
    
    func timeSync() {
        var time: Int = DatabaseService.timeSync()
        
        var path: NSString? = nil
        let manager: NSFileManager = NSFileManager.defaultManager()
        path = NSBundle.mainBundle().bundlePath.stringByAppendingPathComponent("Contents/Time.plist")
        
        if manager.isWritableFileAtPath(path as! String) {
            var infoDict: NSMutableDictionary = NSMutableDictionary(contentsOfFile: path as! String)!
            infoDict.setObject(time, forKey: "time")
            infoDict.writeToFile(path as! String, atomically: false)
        } else {
            path = NSBundle.mainBundle().pathForResource("Time", ofType: "plist")
            var infoDict = NSMutableDictionary(contentsOfFile: path as! String)
            infoDict?.setObject(time, forKey: "time")
            infoDict?.writeToFile(path as! String, atomically: false)
        }
        
        
        if time != Int.min {
            let alert: UIAlertView = UIAlertView(title: "Time Sync Success", message: "Time Sync Completed", delegate: nil, cancelButtonTitle: "OK")
            alert.show()

        } else {
            let alert: UIAlertView = UIAlertView(title: "Time Sync Failed", message: "Have problem to connect to Time Server", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        self.timeLabel.text = "\(time) sec"
    }
    
    func changePIN() {
        let controller: UIAlertController = UIAlertController(title: "Change PIN", message: "Old PIN", preferredStyle: UIAlertControllerStyle.Alert)
        
        let action1: UIAlertAction = UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            let textField: UITextField = controller.textFields![0] as! UITextField
            let config: ConfigEntity = ConfigEntity()
            
            var data: NSMutableArray = config.getValueFromKey(.PASSWORD)
            if textField.text == data[0] as? NSString {
                println("Good")
            }
            
        })
        
        controller.addTextFieldWithConfigurationHandler({ (textField: UITextField!) -> Void in
            textField.secureTextEntry = true
            textField.placeholder = "Old PIN Code"
            textField.keyboardType = UIKeyboardType.PhonePad
        })
        
        controller.addAction(action1)
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
}
