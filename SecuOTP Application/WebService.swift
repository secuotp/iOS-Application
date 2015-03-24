//
//  WebService.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 3/16/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import Foundation

enum ServiceURL: NSString {
    case GET_APP_NAME = "http://128.199.82.168/SecuOTP-Service/database/app-name"
    case GET_APP_INFO = "http://128.199.82.168/SecuOTP-Service/database/app-info"
    case TIME_SYNC = "http://128.199.82.168/SecuOTP-Service/time/sync"
}

enum MediaType: NSString {
    case XML = "application/xml"
    case TEXT = "text/plain"
    case HTML = "application/html"
}

class WebService: NSObject {
    
    
    var url: NSString?
    
    var responseData: NSData?
    init(url:ServiceURL) {
        self.url = url.rawValue
    }
    
    var finished = false
    
    func fetchData(input: NSString, mediaType: MediaType) -> NSData {
        
        responseData = NSMutableData()
        
        var configulation:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var session:NSURLSession = NSURLSession(configuration: configulation)
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: url!)!)
        request.HTTPMethod = "POST"
        request.setValue(mediaType.rawValue, forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = "request=\(input)".dataUsingEncoding(NSUTF8StringEncoding)
        
        var response: NSURLResponse?
        var error: NSError?
        responseData = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        return responseData!
    }
}