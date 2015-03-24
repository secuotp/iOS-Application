//
//  AppInfo.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 3/24/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import Foundation

class AppInfo: NSObject {
    var name: NSString?
    var domain: NSString?
    var serial: NSString?
    var desc: NSString?
    
    init(name:NSString, domain: NSString, serial: NSString, desc: NSString) {
        self.name = name
        self.domain = domain
        self.serial = serial
        self.desc = desc
    }
}