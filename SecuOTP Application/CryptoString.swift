//
//  SHA1.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 3/8/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import Foundation

extension String {
    /// Encrypt Message to SHA-1 Hash
    ///
    /// :returns: SHA-1 Cipher Text.
    func sha1() -> String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output
    }
    
    func hmacSHA1(key: NSString) -> String {
        var useKey: String = ""
        if key.length > 64 {
            useKey = key.sha1()
        }else if key.length < 64 {
            useKey = key + "\((0x00 * (64 - key.length)))"
        } else {
            useKey = key
        }
        
        var oKeyPad = (0x5c * 64) ^ useKey.toInt()!
        var iKeyPad = (0x36 * 64) ^ useKey.toInt()!
        
        var oKeyString: String = oKeyPad.toHexString()
        var iKeyString: String = iKeyPad.toHexString()
        
        return (oKeyString + (iKeyString + self).sha1()).sha1()
    }
    
    func totp(time: NSString, digits: Int) -> String {
        var result: NSString? = nil
        var usingKey: String = time
        let power: [Int] = [1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000]
        
        while countElements(usingKey) < 16 {
            usingKey = "0" + usingKey
        }
        
        var hmac: NSString = self.hmacSHA1(usingKey)
        var hmacByte: [Byte] = (hmac as String).toByteArray()
        var offset: Int = Int(hmacByte[countElements(hmacByte) - 1]) & 0xF
        let binA: Int = (Int(hmacByte[offset]) & 0x7F) << 24
        let binB: Int = (Int(hmacByte[offset + 1]) & 0xFF) << 16
        let binC: Int = (Int(hmacByte[offset + 2]) & 0xFF) << 8
        let binD: Int = Int(hmacByte[offset + 3]) & 0xFF
        
        let binary = binA | binB | binC | binD
        let otp = "\(binary % power[digits])"
        result = otp
        while result?.length < digits {
            result = "0" + result!
        }
        return result!
    }
}

extension NSString {
    func sha1() -> NSString {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output
    }
    
    func hmacSHA1(key: NSString) -> String {
        var useKey: String = ""
        if key.length > 64 {
            useKey = key.sha1()
        }else if key.length < 64 {
            useKey = key + "\((0x00 * (64 - key.length)))"
        } else {
            useKey = key
        }
        
        var oKeyPad = (0x5c * 64) ^ useKey.toInt()!
        var iKeyPad = (0x36 * 64) ^ useKey.toInt()!
        
        var oKeyString: String = oKeyPad.toHexString()
        var iKeyString: String = iKeyPad.toHexString()
        
        return (oKeyString + (iKeyString + self).sha1()).sha1()
    }

}

