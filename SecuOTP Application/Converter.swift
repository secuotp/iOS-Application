
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
    func toByteArray() -> [Byte] {
        var array = [Byte]()
        for char in self.utf8 {
            array += [char as Byte]
        }
        
        return array
    }
    
}