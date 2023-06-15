//
//  String+Ext.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/15/23.
//

import Foundation

extension String {
    
    private var customCharacterSet:CharacterSet {
        var charSet = NSCharacterSet.urlQueryAllowed
        let remove = "+&"
        for char in remove.unicodeScalars {
            charSet.remove(char)
        }
        
        return charSet
    }
    
    func urlEncode() -> String {
        guard let encoded = self.addingPercentEncoding(withAllowedCharacters: customCharacterSet) else {
            return self
        }
        
        return encoded
    }
}
