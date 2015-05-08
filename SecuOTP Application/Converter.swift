
//
//  File.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 3/8/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import Foundation

extension Int {
    func toString(#radix: Int) -> String {
        assert(2...35 ~= radix, "radix must be between 2 and 35")
        if self == 0 { return "0" }
        
        let negative = self < 0
        var num = abs(self)
        var result = ""
        while num != 0 {
            let digit = num % radix
            if digit < 10 { result = "\(digit)\(result)" }
            else { result = String(Character(UnicodeScalar(digit + 55))) + result }
            num /= radix
        }
        
        return (negative ? "-" : "") + result
    }
    
    func toHexString() -> String {
        return self.toString(radix: 16)
    }
}


extension String {
    func toByteArray() -> [UInt8] {
        var array = [UInt8]()
        for char in self.utf8 {
            array += [char as UInt8]
        }
        
        return array
    }
    
    
    
    func str2num() -> UInt32 {
        var charArray = Array(self)
        var result: UInt32 = 0
        for i: Character in charArray {
            for j in String(i).unicodeScalars {
                result += j.value
            }
        }
        return result
    }
    
}

extension NSData {
    func hexadecimalString() -> String {
        var string = NSMutableString(capacity: length * 2)
        var byte: UInt8 = 0
        
        for i in 0 ..< length {
            getBytes(&byte, range: NSMakeRange(i, 1))
            string.appendFormat("%02x", byte)
        }
        
        return string as String
    }
}

extension NSDate {
    func reformatTime(hour:Int, minute:Int, second:Int) -> NSDate {
        var time: UInt64 = UInt64(self.timeIntervalSince1970 * 1000)
        var format: UInt64 = UInt64((second * 1000) + (minute * 60 * 1000) + (hour * 60 * 60 * 1000))
        
        var formatTime = UInt64(floor(Double(time) / Double(format))) * format
        var a = Double(formatTime) / 1000
        var date: NSDate = NSDate(timeIntervalSince1970: a)
        return date
    }
}