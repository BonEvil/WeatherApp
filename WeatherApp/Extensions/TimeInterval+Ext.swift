//
//  TimeInterval+Ext.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

extension TimeInterval {
    
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "h:mma"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        let dateString = formatter.string(from: Date(timeIntervalSince1970: self))
        return dateString
    }
}
