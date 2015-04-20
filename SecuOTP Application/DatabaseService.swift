//
//  DatabaseService.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 3/17/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import Foundation

class DatabaseService {
    
    class func getAppName(keyword: NSString) -> [NSString]? {
        let service:WebService = WebService(url: ServiceURL.GET_APP_NAME)
        
        let response: NSData? = service.fetchData(keyword, mediaType: MediaType.TEXT)
        
        if response != nil {
            var result: [NSString] = response?.parseXML("/secuotp/*") as! [NSString]
            return result
        } else {
            return nil
        }
    }
    
    class func getAppInfo(keyword: NSString) -> AppInfo? {
        let service: WebService = WebService(url: ServiceURL.GET_APP_INFO)
        if keyword.length > 0 {
            let response: NSData? = service.fetchData(keyword, mediaType: MediaType.TEXT)!
        
            if response != nil {
                var result: [NSString] = response?.parseXML("/secuotp/info/*") as! [NSString]
        
                var info = AppInfo(name: result[0], domain: result[1], serial: result[2], desc: result[3])
                return info
            }
        }
        return nil
    }
    
    class func approveMigrateService(code: NSString) -> Bool{
        let service: WebService = WebService(url: ServiceURL.APPROVE_MIGRATE)
        let response: NSData? = service.fetchData(code, mediaType: MediaType.TEXT)!

        if response != nil {
            var result: [NSString] = response?.parseXML("/secuotp/@check")as! [NSString]

            if result[0].intValue == 1 {
                result = response?.parseXML("/secuotp/*")as! [NSString]
                let config: SiteEntity = SiteEntity()
                config.siteName = result[0]
                config.siteDomain = result[1]
                config.siteSerial = result[2]
                config.siteDescription = result[3]
                config.userSerial = result[4]
                config.userRemoval = result[5]
                config.otpLength = result[6]
                config.otpPattern = result[7]
                config.siteImage = result[8]
                println("Data: \n\(response?.bytes)")
                return config.save()
            }
        }
        return false
    }
}