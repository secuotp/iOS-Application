//
//  SiteEntity.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 3/29/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit
import CoreData

enum SiteEntityKey: NSString {
    case SITE_NAME = "site_name"
    case SITE_DOMAIN = "site_domain"
    case SITE_SERIAL = "site_serial"
    case SITE_DESC = "site_description"
    case USER_SERIAL = "user_serial"
    case USER_REMOVAL = "user_removal"
    case OTP_LENGTH = "otp_length"
    case OTP_PATTERN = "otp_pattern"
}

class SiteEntity: NSObject {
    // PRIVATE PARAM
    private let context : NSManagedObjectContext
    private let entity : NSEntityDescription
    private let object : NSManagedObject
    
    // PUBLIC PARAM
    let entityName : NSString = "Site"
    var siteName: NSString?
    var siteDomain: NSString?
    var siteSerial: NSString?
    var siteDescription: NSString?
    var userSerial: NSString?
    var userRemoval: NSString?
    var otpLength: NSString?
    var otpPattern: NSString?
    
    override init(){
        context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        
        entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)!
        object = NSManagedObject(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    func save() -> Bool {
        object.setValue(siteName, forKey: SiteEntityKey.SITE_NAME.rawValue)
        object.setValue(siteDomain, forKey: SiteEntityKey.SITE_DOMAIN.rawValue)
        object.setValue(siteSerial, forKey: SiteEntityKey.SITE_SERIAL.rawValue)
        object.setValue(siteDescription, forKey: SiteEntityKey.SITE_DESC.rawValue)
        object.setValue(userSerial, forKey: SiteEntityKey.USER_SERIAL.rawValue)
        object.setValue(userRemoval, forKey: SiteEntityKey.USER_REMOVAL.rawValue)
        object.setValue(otpLength, forKey: SiteEntityKey.OTP_LENGTH.rawValue)
        object.setValue(otpPattern, forKey: SiteEntityKey.OTP_PATTERN.rawValue)
        
        var error : NSError?
        context.save(&error)
        
        return error == nil
    }
    
    // Start at 1 row
    func recordCount() -> NSInteger {
        let array = self.fetch()
        return array.count
    }
    
    // Fetch all Records in SqlLite (Config Entity)
    func fetch() -> [NSManagedObject] {
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: entityName)
        var error : NSError?
        let fetchResults : [NSManagedObject] = context.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]!
        
        return fetchResults
    }
    
    func getValueFromKey(key: NSString) -> NSMutableArray {
        let dataArray: [NSManagedObject] = self.fetch()
        
        let data: NSMutableArray = NSMutableArray(capacity: dataArray.count)
        
        for var i = 0; i < dataArray.count; i++ {
            
            if dataArray[i].valueForKey(key) != nil {
                data.addObject(dataArray[i].valueForKey(key) as NSString)
            }
        }
        return data
    }
    
}