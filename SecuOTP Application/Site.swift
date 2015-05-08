//
//  Site.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 3/30/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class Site: NSObject {
    var siteName: NSString?
    var siteDomain: NSString?
    var siteSerial: NSString?
    var siteDescription: NSString?
    var siteImage: UIImage?
    var userSerial: NSString?
    var userRemoval: NSString?
    var otpLength: Int?
    var otpPattern: NSString?
    
    func calcOTP() -> NSDictionary {
        let allKey: [NSString] = getKeyMessage()
        let allTime: [NSDate] = getTimeReformatter()
        
        let remaining = abs(allTime[1].timeIntervalSince1970 - allTime[0].timeIntervalSince1970)
        
        let time: NSString = "\(Int(allTime[1].timeIntervalSince1970) * 1000)"
        let otp = (allKey[2] as String).totp(time, digits: otpLength!)
        
        var dict: NSMutableDictionary = NSMutableDictionary()
        dict.setObject(remaining, forKey: "remaining")
        dict.setObject(otp, forKey: "otp")
        
        return dict as NSDictionary
    }
    
    private func getKeyMessage() -> [NSString] {
        let message = "SecuOTP"
        let privateString = "\(self.userSerial as! String) \(self.siteSerial as! String) SecuOTP"
        let privateNum = privateString.str2num()
        let privateKey = "\(privateNum)"
        
        var key: NSString = "\(userSerial as! String)-\(siteSerial as! String)-\(message.hmacSHA1(privateKey))"
        var keyData: NSData = key.dataUsingEncoding(NSUTF8StringEncoding)!
        
        key = keyData.hexadecimalString()
        
        if key.length > 100 {
            key = key.substringToIndex(100)
        } else {
            while key.length < 100 {
                key = "0" + (key as String)
            }
        }
        return [message, privateKey, key]
    }
    
    private func getTimeReformatter() -> [NSDate] {
        let path = NSBundle.mainBundle().pathForResource("Time", ofType: "plist")
        let dict: NSDictionary = NSDictionary(contentsOfFile: path!)!
        let diff: Int = dict.objectForKey("time") as! Int
        
        var time = NSDate()
        time = NSDate(timeIntervalSince1970: time.timeIntervalSince1970 + Double(diff))
        let formatter = time.reformatTime(0, minute: 0, second: 30)
        return [time, formatter]
    }
}