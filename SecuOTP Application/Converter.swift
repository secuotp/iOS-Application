
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