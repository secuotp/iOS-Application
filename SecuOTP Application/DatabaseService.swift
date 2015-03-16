//
//  DatabaseService.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 3/17/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import Foundation

class DatabaseService: NSObject {
    
    class func getAppName(keyword: NSString) -> [NSString] {
        let service:WebService = WebService(url: ServiceURL.GET_APP_NAME.rawValue)
        var data: NSData = service.fetchData(keyword)
        
        return [NSString]()
    }
}