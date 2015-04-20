//
//  AddApplicationViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 3/14/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class AddApplicationViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var list: [NSString] = [NSString]()
    var appInfo: AppInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return list.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        var label: UILabel?
        if tableView == self.searchDisplayController?.searchResultsTableView {
            label = cell?.textLabel
        } else {
            label = cell?.viewWithTag(1) as? UILabel
        }
        label?.text = list[indexPath.row] as String
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell: UITableViewCell? = tableView.cellForRowAtIndexPath(indexPath)
        if cell != nil {
            appInfo = DatabaseService.getAppInfo(list[indexPath.row])
        }
        var controller: UIAlertController = UIAlertController(title: appInfo?.name as? String, message: "Please enter your Magration Code", preferredStyle: UIAlertControllerStyle.Alert)
        var action: UIAlertAction = UIAlertAction(title: "Submit", style: .Default, handler: { (alertAction: UIAlertAction!) -> Void in
            let codeField: UITextField = controller.textFields![0] as! UITextField
            let code = codeField.text
            
            if DatabaseService.approveMigrateService(code) {
                let alert: UIAlertView = UIAlertView(title: "Add Application Success", message: "Congratulation you successfully migrate \(self.appInfo?.name!) into your application", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                let alert: UIAlertView = UIAlertView(title: "Migration Failed", message: "Incorrect Migration Code", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        })
        
        var cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        controller.addTextFieldWithConfigurationHandler({ (textField: UITextField!) -> Void in
            textField.placeholder = "Migration Code"
        })
        
        cell?.setSelected(false, animated: true)
        
        controller.addAction(action)
        controller.addAction(cancel)
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    
    func filterContentForSearchText(searchText: NSString) {
        let tmp: [NSString]? = DatabaseService.getAppName(searchText)!
        if tmp != nil {
            list = tmp!
        }
        
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        list = [NSString]()
        if count(searchString) > 0 {
            self.filterContentForSearchText(searchString)
        }
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        return true
    }
}
