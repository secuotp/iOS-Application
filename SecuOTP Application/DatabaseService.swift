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
    
    class func timeSync() -> Int {
        let service: WebService = WebService(url: ServiceURL.TIME_SYNC)
        let response: NSData? = service.fetchData()
        if response != nil {
            let result: [NSString] = response?.parseXML("/secuotp/time") as! [NSString]
            var ntpTime: Int = result[0].integerValue
            var ntpDate: NSDate = NSDate(timeIntervalSince1970: (Double(ntpTime / 1000)))
            var machineDate: NSDate = NSDate()
            var diff: Int = (ntpTime - Int(machineDate.timeIntervalSince1970) * 1000) / 1000
            
            return diff
            
        }
        return Int.min
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
                
                let imgHttpPath: NSURL = NSURL(string: result[8] as String)!
                config.siteImage = NSData(contentsOfURL: imgHttpPath)
                
                println("Data: \n\(response?.bytes)")
                return config.save()
            }
        }
        return false
    }
}