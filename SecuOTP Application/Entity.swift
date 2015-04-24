//
//  Entity.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/26/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit
import CoreData

protocol Entity {
    func save() -> Bool
    func fetch() -> [NSManagedObject]
    func recordCount() -> NSInteger
}
