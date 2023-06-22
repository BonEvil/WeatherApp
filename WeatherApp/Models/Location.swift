//
//  Location.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

struct Location: Codable, Identifiable {
    
    private static var lastLocationKey = "_lastLocation"
    
    let name: String
    let lat: Float
    let lon: Float
    let country: String
    let state: String?
    
    var id: Float { lat + lon }
}

extension Location {

    func saveLastLocation() {
        let location = ["name": self.name,
                        "lat": "\(self.lat)",
                        "lon": "\(self.lon)",
                        "country": self.country,
                        "state": self.state  != nil ? self.state! : ""]
        UserDefaults.standard.set(location, forKey: Location.lastLocationKey)
    }

    static func lastLocation() -> Location? {
        guard let location = UserDefaults.standard.object(forKey: Location.lastLocationKey) as? [String: String] else {
            return nil
        }
        
        guard let name = location["name"],
              let latString = location["lat"],
              let lat = Float(latString),
              let lonString = location["lon"],
              let lon = Float(lonString),
              let country = location["country"],
              let state = location["state"] else {
            removeLastLocation()
            
            return nil
        }
        
        return Location(name: name, lat: lat, lon: lon, country: country, state: state == "" ? nil : state)
    }

    static func removeLastLocation() {
        if UserDefaults.standard.object(forKey: Location.lastLocationKey) != nil {
            UserDefaults.standard.removeObject(forKey: Location.lastLocationKey)
        }
    }
}
