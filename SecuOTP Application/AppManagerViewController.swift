//
//  AppManagerViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/26/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit
import CoreData

class AppManagerViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableViewManager: UITableView!
    
    var item: [NSString] = [NSString]()
    var image: [UIImage?] = [UIImage?]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        item = [NSString]()
        
        let siteList: SiteEntity = SiteEntity()
        let data: [Site] = siteList.fetch()
        
        for i: Site in data{
            if i.siteName != nil{
                item.append(i.siteName!)
                image.append(i.siteImage)
            }
        }
        self.tableView.reloadData()
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
        var label: UILabel = tableViewCell?.viewWithTag(1) as! UILabel
        var wallpaper: UIImageView = tableViewCell?.viewWithTag(2) as! UIImageView
        label.text = item[indexPath.row] as String
        if image[indexPath.row] != nil {
            wallpaper.image = image[indexPath.row]
        }
        
        return tableViewCell as! UITableViewCell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("AppManagerToOTP", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AppManagerToOTP" {
            let viewController: OTPViewController = segue.destinationViewController as! OTPViewController
            let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
            viewController.appName = item[indexPath.row]
            
        }
    }
}
