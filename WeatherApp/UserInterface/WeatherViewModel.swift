//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

class WeatherViewModel: WeatherProtocol, PlaceProtocol {
    
    private var setLocation: ((String) -> Void)?
    private var setSunrise: ((String) -> Void)?
    private var setSunset: ((String) -> Void)?
    private var setTemperature: ((String) -> Void)?
    private var setFeelsLike: ((String) -> Void)?
    private var setWindSpeed: ((String) -> Void)?
    private var setMainFeature: ((String) -> Void)?
    private var setMainDescription: ((String) -> Void)?
    private var setWeatherIcon: ((String) -> Void)?
    
    func bindLocaton(_ action: @escaping ((String) -> Void)) {
        self.setLocation = action
    }
    
    func bindSunrise(_ action: @escaping ((String) -> Void)) {
        self.setSunrise = action
    }
    
    func bindSunset(_ action: @escaping ((String) -> Void)) {
        self.setSunset = action
    }
    
    func bindTemperature(_ action: @escaping ((String) -> Void)) {
        self.setTemperature = action
    }
    
    func bindFeelsLike(_ action: @escaping ((String) -> Void)) {
        self.setFeelsLike = action
    }
    
    func bindWindspeed(_ action: @escaping ((String) -> Void)) {
        self.setWindSpeed = action
    }
    
    func bindMainFeature(_ action: @escaping ((String) -> Void)) {
        self.setMainFeature = action
    }
    
    func bindMainDescription(_ action: @escaping ((String) -> Void)) {
        self.setMainDescription = action
    }
    
    func bindWeatherIcon(_ action: @escaping ((String) -> Void)) {
        self.setWeatherIcon = action
    }
    
    func searchForPlace(_ place: Place) async throws -> [LocationResponse] {
        do {
            let locations = try await ServiceController.getLatLonFromPlace(place)
            return locations
        } catch {
            throw error
        }
    }
    
    func getWeatherForLocation(_ location: Location, unit: Unit) async throws {
        setLocation?(location.name)
        do {
            let weatherResponse = try await ServiceController.getCurrentWeatherForLocation(location, unit: unit)
            setSunrise?(weatherResponse.current.sunrise.formatDate())
            setSunset?(weatherResponse.current.sunset.formatDate())
            print("\(weatherResponse)")
        } catch {
            throw error
        }
    }
}
