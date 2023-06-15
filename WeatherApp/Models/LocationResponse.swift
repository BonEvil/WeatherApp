//
//  LocationResponse.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

struct LocationResponse: Codable, Identifiable {
    let name: String
    let lat: Float
    let lon: Float
    let country: String
    let state: String?
    
    var id: Float { lat + lon }
}
