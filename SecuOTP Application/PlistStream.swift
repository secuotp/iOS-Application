//
//  ioPlist.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/10/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class PlistStream {
    let fileName : String = "DataSotrage"
    let fileExtension : String = "plist"
    
    var plistPath : String!
    var array : NSMutableArray!
    var dataDict : NSMutableDictionary!
    
    init() {
        // Search iOS Directory to find Interesting File
        plistPath = self.docDir().stringByAppendingPathComponent(fileName + "." + fileExtension)
        
        // Check if Interesting File not found
        if(!NSFileManager.defaultManager().fileExistsAtPath(plistPath)){
            NSFileManager.defaultManager().copyItemAtPath(NSBundle.mainBundle().pathForResource(fileName, ofType: fileExtension)!, toPath: plistPath, error: nil)
        }
        
        // Get Data Dictionary from file
        dataDict = NSMutableDictionary(contentsOfFile: plistPath)!
    }
    
    
    // Get value from Key given
    func getPlistValue(Key key : String) -> String {
        return dataDict.objectForKey(key) as String
    }
    
    // Set value from Key given
    func setPlistValue(Key key : String, Value value : String) {
        dataDict.setObject(value, forKey: key)
        
        dataDict.writeToFile(plistPath, atomically: true)
    }
    
    private func docDir() -> String{
        return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    }
    
}
