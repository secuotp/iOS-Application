//
//  DatabaseService.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 3/17/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import Foundation

class DatabaseService {
    
    class func getAppName(keyword: NSString) -> [NSString] {
        let service:WebService = WebService(url: ServiceURL.GET_APP_NAME)
        
        let response: NSData = service.fetchData(keyword, mediaType: MediaType.TEXT)
        
        var result: [NSString] = response.parseXML("/secuotp/*") as [NSString]
        return result
    }
    
    class func getAppInfo(keyword: NSString) -> AppInfo {
        let service: WebService = WebService(url: ServiceURL.GET_APP_INFO)
        
        let response: NSData = service.fetchData(keyword, mediaType: MediaType.TEXT)
        
        let doc: CXMLDocument = CXMLDocument(data: response, options: 0, error: nil)
        
        var result: [NSString] = response.parseXML("/secuotp/info/*") as [NSString]
        
        var info = AppInfo(name: result[0], domain: result[1], serial: result[2], desc: result[3])
        return info
    }
    
}