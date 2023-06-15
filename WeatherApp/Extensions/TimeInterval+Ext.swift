//
//  TimeInterval+Ext.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

extension TimeInterval {
    
    /// Formats a `TimeInterval` using UTC timezone to a simple string output
    /// - Parameter offset: number of seconds to offset from UTC time
    /// - Returns: a string from the `TimeInterval` in the format of "h:mma"
    func formatDate(withOffset offset: Double) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "h:mma"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        let dateString = formatter.string(from: Date(timeIntervalSince1970: self + offset))
        return dateString
    }
}
