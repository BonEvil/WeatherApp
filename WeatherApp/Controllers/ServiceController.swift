//
//  ServiceController.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation
import BuckarooBanzai

/// Controller to make network calls to retrieve geocode information and, subsequently, current weather for that geo location
struct ServiceController {
    
    static func getLatLonFromLocation(_ location: String) async throws -> [LocationResponse] {
        
        let service = GeoCodeService(withPlace: "\(location)")
        do {
            let response = try await BuckarooBanzai.shared.start(service: service)
            let locations: [LocationResponse] = try response.decodeBodyData(convertFromSnakeCase: true)
            return locations
        } catch {
            throw error
        }
    }
    
    static func getCurrentWeatherForLocation(_ location: LocationResponse, unit: Unit) async throws -> WeatherResponse {
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
