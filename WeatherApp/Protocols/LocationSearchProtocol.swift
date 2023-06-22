//
//  PlaceProtocol.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

/// Protocols for location finding and selection
protocol LocationSearchProtocol {
    /// Protocol to search for a location from a text input
    /// - Parameter location: The text input to try to match a location
    /// - Returns: An array of `LocationResponse` objects as defined by the Open Weather service
    func searchForLocation(_ location: String) async throws -> [LocationResponse]
    
    /// Start a process to get the current location of the user
    func getCurrentLocation()
}
