//
//  PlaceProtocol.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

/// Protocols for location finding and selection
protocol LocationSearchProtocol {
    func searchForLocation(_ location: String) async throws -> [LocationResponse]
    func getCurrentLocation()
}
