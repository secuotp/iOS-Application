//
//  XMLParser.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 3/25/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import Foundation

extension NSData {
    func parseXML(xPath: NSString) -> [AnyObject]? {
        var documentError: NSError?
        let document: CXMLDocument = CXMLDocument(data: self, options: 0, error: &documentError)
        
        if documentError != nil {
            return nil
        } else {
            var parseError: NSError?
            var nodes: NSArray = document.nodesForXPath(xPath as String, error: &parseError) as! [CXMLElement]
        
            if parseError != nil {
                return nil
            } else {
                var result: [AnyObject] = [AnyObject]()
                for i: CXMLNode in nodes as! [CXMLNode] {
                    result.append(i.stringValue())
                }
                return result
            }
        }
    }
}