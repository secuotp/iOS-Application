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
        
        var response: NSData = service.fetchData(keyword, mediaType: MediaType.TEXT)
        println("Data is \(NSString(data: response, encoding: NSUTF8StringEncoding) as String)")
        
        var doc: CXMLDocument = CXMLDocument(data: response, options: 0, error: nil)

        var nodes: [CXMLElement] = doc.nodesForXPath("/secuotp/*", error: nil) as [CXMLElement]
        
        var result: [NSString] = [NSString]()
        for i: CXMLElement in nodes {
            result.append(i.stringValue())
        }
        return result
    }
    
    class func getAppInfo(keyword: NSString) -> AppInfo {
        return AppInfo()
    }
    
}