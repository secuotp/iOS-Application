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

class AppName: NSObject {
    var name: NSString?
}


class WebService: NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate{
    
    
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
    
        /*
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        self.responseData?.length = 0
        println("Status Code: \((response as NSHTTPURLResponse).statusCode)")
        
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.responseData?.appendData(data)
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        println("Failed with error \(error.description)")
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var responseString: NSString = NSString(data: self.responseData!, encoding: NSUTF8StringEncoding)!
        println(responseString)
        finished == true
    }
    
    // Bypass SSL
    func connection(connection: NSURLConnection, willSendRequestForAuthenticationChallenge challenge: NSURLAuthenticationChallenge) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let baseUrl: NSURL = NSURL(string: self.url!)!
            if challenge.protectionSpace.host == baseUrl.host {
                println("Trusting connection to host \(challenge.protectionSpace.host)")
                challenge.sender.useCredential(NSURLCredential(forTrust: challenge.protectionSpace.serverTrust), forAuthenticationChallenge: challenge)
            } else {
                println("Not trusting connection to host \(challenge.protectionSpace.host)")
            }
        }
        challenge.sender.continueWithoutCredentialForAuthenticationChallenge(challenge)
    }

    
    func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: NSURLProtectionSpace) -> Bool {
        return protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
    }
    */
}