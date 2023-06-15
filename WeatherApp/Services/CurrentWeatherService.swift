//
//  CurrentWeatherService.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

enum Unit: String {
    case imperial
    case metric
}

struct CurrentWeatherQuery {
    let lat: Float
    let lon: Float
    let unit: Unit
}

/// Service class to retrieve the current weather of a given lat/lon
class CurrentWeatherService: BaseWeatherService {
    
    required init(withCurrentWeatherData data: CurrentWeatherQuery) {
        super.init(withPath: "/data/3.0/onecall?lat=\(data.lat)&lon=\(data.lon)&units=\(data.unit.rawValue)&exlude=minutely,hourly,daily,alerts")
    }
}
