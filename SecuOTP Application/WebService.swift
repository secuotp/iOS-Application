//
//  WebService.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 3/16/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import Foundation

enum ServiceURL: NSString {
    case GET_APP_NAME = "https://128.199.82.168/SecuOTP-Service/database/app-name"
    case GET_APP_INFO = "https://128.199.82.168/SecuOTP-Service/database/app-info"
    case TIME_SYNC = "https://128.199.82.168/SecuOTP-Service/time/sync"
}

class WebService: NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate{
    
    var url: NSString?
    
    var responseData: NSMutableData?
    init(url:NSString) {
        self.url = url
    }
    
    func fetchData(xml: NSString) -> NSData {
        responseData = NSMutableData()
        var configulation:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var session:NSURLSession = NSURLSession(configuration: configulation)
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: url!)!)
        request.HTTPMethod = "POST"
        request.setValue("application/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = xml.dataUsingEncoding(NSUTF8StringEncoding)
        
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        connection.start()
        
        return responseData!
    }
    
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
    
}