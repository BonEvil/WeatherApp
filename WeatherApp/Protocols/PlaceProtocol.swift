//
//  PlaceProtocol.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

/// Protocols for location finding and selection
protocol PlaceProtocol {
    func searchForPlace(_ place: String) async throws -> [LocationResponse]
    func onSelect(_ location: Location, _ unit: Unit)
    func getCurrentLocation()
}
