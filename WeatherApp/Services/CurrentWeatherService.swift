//
//  CurrentWeatherService.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

enum Unit: String {
    static var lastUnitKey = "_lastUnit"
    
    case imperial
    case metric
    
    func saveLastUnit() {
        UserDefaults.standard.set("\(self)", forKey: Unit.lastUnitKey)
    }
    
    static func lastUnit() -> Unit? {
        guard let unit = UserDefaults.standard.object(forKey: Unit.lastUnitKey) as? String else {
            return nil
        }
        
        return unit == "imperial" ? .imperial : .metric
    }
    
    static func removeLastUnit() {
        if UserDefaults.standard.object(forKey: Unit.lastUnitKey) != nil {
            UserDefaults.standard.removeObject(forKey: Unit.lastUnitKey)
        }
    }
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
