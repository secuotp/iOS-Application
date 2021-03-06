//
//  ConfigEntity.swift
//  SecuOTP-Application
//
//  Created by Panasan Sinroungrong on 2/24/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit
import CoreData

enum ConfigEntityKey: NSString {
    case PASSWORD = "Password"
}

class ConfigEntity: NSObject, Entity {
    // PRIVATE PARAM
    private let context : NSManagedObjectContext
    private let entity : NSEntityDescription
    private let object : NSManagedObject
    
    // PUBLIC PARAM
    let entityName : NSString = "Config"
    var password: NSString?
    
    override init(){
        context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        entity = NSEntityDescription.entityForName(entityName as String, inManagedObjectContext: context)!
        object = NSManagedObject(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    func save() -> Bool {
        object.setValue(password, forKey: ConfigEntityKey.PASSWORD.rawValue as String)
        
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
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: entityName as String)
        var error : NSError?
        let fetchResults : [NSManagedObject] = context.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]!
        
        return fetchResults
    }
    
    func getValueFromKey(key: ConfigEntityKey) -> NSMutableArray {
        let dataArray: [NSManagedObject] = self.fetch()
        
        let data: NSMutableArray = NSMutableArray(capacity: dataArray.count)
        
        for var i = 0; i < dataArray.count; i++ {
            
            if dataArray[i].valueForKey(key.rawValue as String) != nil {
                data.addObject(dataArray[i].valueForKey(key.rawValue as String) as! NSString)
            }
        }
        return data
    }
    
    func delete(key: ConfigEntityKey, data: NSString) -> Bool {
        let objects: [NSManagedObject] = self.fetch()
        for var i = 0; i < objects.count; i++ {
            if objects[i].valueForKey(key.rawValue as String) as! NSString == data {
                context.deleteObject(objects[i])
                return true
            }
        }
        return false
    }
    
    func delete(key: ConfigEntityKey, data: NSString) -> NSManagedObject? {
        let objects: [NSManagedObject] = self.fetch()
        for i: NSManagedObject in objects {
            if (i.valueForKey(key.rawValue as String)) as! NSString == data {
                let objectInterest: NSManagedObject? = i
                context.deleteObject(i)
                return objectInterest
            }
        }
        return nil
    }
    
    func delete(key: ConfigEntityKey, data: Int) -> NSManagedObject? {
        let objects: [NSManagedObject] = self.fetch()
        for i: NSManagedObject in objects {
            if (i.valueForKey(key.rawValue as String)) as! Int == data {
                let objectInterest: NSManagedObject? = i
                context.deleteObject(i)
                return objectInterest
            }
        }
        return nil
    }

}
