//
//  SiteEntity.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 3/29/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit
import CoreData

enum SiteEntityKey: String {
    case SITE_NAME = "site_name"
    case SITE_DOMAIN = "site_domain"
    case SITE_SERIAL = "site_serial"
    case SITE_DESC = "site_description"
    case USER_SERIAL = "user_serial"
    case USER_REMOVAL = "user_removal"
    case OTP_LENGTH = "otp_length"
    case OTP_PATTERN = "otp_pattern"
    case SITE_IMAGE = "site_image"
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
    var siteImage: NSData?
    
    override init(){
        context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        entity = NSEntityDescription.entityForName(entityName as String, inManagedObjectContext: context)!
        object = NSManagedObject(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    func save() -> Bool {
        object.setValue(siteName, forKey: SiteEntityKey.SITE_NAME.rawValue)
        object.setValue(siteDomain, forKey: SiteEntityKey.SITE_DOMAIN.rawValue)
        object.setValue(siteSerial, forKey: SiteEntityKey.SITE_SERIAL.rawValue)
        object.setValue(siteDescription, forKey: SiteEntityKey.SITE_DESC.rawValue)
        object.setValue(siteImage, forKey: SiteEntityKey.SITE_IMAGE.rawValue)
        object.setValue(userSerial, forKey: SiteEntityKey.USER_SERIAL.rawValue)
        object.setValue(userRemoval, forKey: SiteEntityKey.USER_REMOVAL.rawValue)
        object.setValue(otpLength, forKey: SiteEntityKey.OTP_LENGTH.rawValue)
        object.setValue(otpPattern, forKey: SiteEntityKey.OTP_PATTERN.rawValue)
        object.setValue(otpPattern, forKey: SiteEntityKey.OTP_PATTERN.rawValue)
        
        var error : NSError?
        context.save(&error)
        
        return error == nil
    }
    
    // Start at 1 row
    func recordCount() -> NSInteger {
        let array = self.fetch()
        if array.count > 0 {
            return array.count
        } else {
            return 0
        }
    }
    
    // Fetch all Records in SqlLite (Config Entity)
    func fetch() -> [Site] {
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: entityName as String)
        var error : NSError?
        let fetchResults : NSArray? = context.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]!
        
        var resultObject: [Site] = [Site]()
        if fetchResults != nil{
            for i: NSManagedObject in (fetchResults as! [NSManagedObject]) {
                var site = Site()
                site.siteName = i.valueForKey(SiteEntityKey.SITE_NAME.rawValue) as! NSString?
                site.siteDomain = i.valueForKey(SiteEntityKey.SITE_DOMAIN.rawValue) as! NSString?
                site.siteSerial = i.valueForKey(SiteEntityKey.SITE_SERIAL.rawValue) as! NSString?
                site.siteDescription = i.valueForKey(SiteEntityKey.SITE_DESC.rawValue) as! NSString?
                
                var imgString: NSData? = (i.valueForKey(SiteEntityKey.SITE_IMAGE.rawValue) as! NSData?)
                if imgString != nil {
                    site.siteImage = UIImage(data: imgString!)
                }
                site.userSerial = i.valueForKey(SiteEntityKey.USER_SERIAL.rawValue) as! NSString?
                site.userRemoval = i.valueForKey(SiteEntityKey.USER_REMOVAL.rawValue) as! NSString?
                
                var length: NSString? = i.valueForKey(SiteEntityKey.OTP_LENGTH.rawValue) as! NSString?
                if length != nil {
                    site.otpLength = Int(length!.intValue)
                }
                site.otpPattern = i.valueForKey(SiteEntityKey.OTP_PATTERN.rawValue) as! NSString?
                
                resultObject.append(site)
            }
            return resultObject
        } else {
            return [Site]()
        }
    }
}
