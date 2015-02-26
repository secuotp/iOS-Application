//
//  ConfigEntity.swift
//  SecuOTP-Application
//
//  Created by Panasan Sinroungrong on 2/24/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit
import CoreData

class ConfigEntity: NSObject, Entity {
    // PRIVATE PARAM
    private let context : NSManagedObjectContext
    private let entity : NSEntityDescription
    private let object : NSManagedObject
    
    // PUBLIC PARAM
    let entityName : NSString = "Config"
    var password: NSString?
    
    override init(){
        context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        
        entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)!
        object = NSManagedObject(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    func save() {
        object.setValue(password, forKey: "password")
        
        var error : NSError?
        context.save(&error)
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
