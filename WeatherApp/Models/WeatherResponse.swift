//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

struct WeatherResponse: Codable {
    let lat: Float
    let lon: Float
    let timezone: String
    let timezoneOffset: Int
    let current: Current
}

struct Current: Codable {
    let dt: TimeInterval
    let sunrise: TimeInterval
    let sunset: TimeInterval
    let temp: Float
    let feelsLike: Float
    let pressure: Int
    let humidity: Int
    let dewPoint: Float
    let uvi: Float
    let clouds: Int
    let visibility: Int
    let windSpeed: Float
    let windDeg: Int
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
