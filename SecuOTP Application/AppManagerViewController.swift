//
//  AppManagerViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/14/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class AppManagerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Outlet Only
    @IBOutlet weak var tableView: UITableView!

    var item = ["a", "b", "c", "d", "e", "f", "g"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This Function will counting cell in UITableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    // This Function will add Table cell to UITableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // get UITableCell from View Prototype as Object
        var cellTableView: AnyObject? = self.tableView.dequeueReusableCellWithIdentifier("cell")
        
        // Check if View prototype Doesn't Exist
        if(cellTableView == nil){
            cellTableView = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        //create Label from Prototype Tag Number & set Text
        var label : UILabel = cellTableView?.viewWithTag(1) as UILabel
        label.text = item[indexPath.row]
        
        return cellTableView as UITableViewCell
    }
    
    
    // This Function will do somthing when the cell was selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("AppManagerToViewOTP", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "AppManagerToViewOTP"){
            var indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow()!
            let destViewController : OTPViewController = segue.destinationViewController
             as OTPViewController
            destViewController.titleName = item[indexPath.item]
        }
    }
}
