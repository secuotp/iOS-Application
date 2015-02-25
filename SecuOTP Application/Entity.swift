//
//  Entity.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/26/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import Foundation
import CoreData

protocol Entity {
    func save()
    func fetch() -> NSArray
    func recordCount() -> NSInteger
}