//
//  ServiceController.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation
import BuckarooBanzai

struct Location: Codable {
    let name: String
    let lat: Float
    let lon: Float
}

struct ServiceController {
    
    static func getLatLonFromPlace(_ place: String) async throws -> [LocationResponse] {
        
        let service = GeoCodeService(withPlace: "\(place)")
        do {
            let response = try await BuckarooBanzai.shared.start(service: service)
            let locations: [LocationResponse] = try response.decodeBodyData(convertFromSnakeCase: true)
            return locations
        } catch {
            throw error
        }
    }
    
    static func getCurrentWeatherForLocation(_ location: Location, unit: Unit) async throws -> WeatherResponse {
        let data = CurrentWeatherQuery(lat: location.lat, lon: location.lon, unit: unit)
        let service = CurrentWeatherService(withCurrentWeatherData: data)
        do {
            let response = try await BuckarooBanzai.shared.start(service: service)
            let weatherResponse: WeatherResponse = try response.decodeBodyData(convertFromSnakeCase: true)
            return weatherResponse
        } catch {
            throw error
        }
    }
}
