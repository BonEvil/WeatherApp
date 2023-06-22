//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

/// The viewModel to support the WeatherViewController
/// Elements of the View Controller bind to the viewModel for updates to the view
class WeatherViewModel {
    
    let defaultLocationButtonTitle = "Set Location"
    let defaultTemperatureText = "--°"
    let defaultText = "--"
    
    private var setLocation: ((String) -> Void)?
    private var setSunrise: ((String) -> Void)?
    private var setSunset: ((String) -> Void)?
    private var setTemperature: ((String) -> Void)?
    private var setWindSpeed: ((String) -> Void)?
    private var setCondition: ((String) -> Void)?
    private var setWeatherIcon: ((String) -> Void)?
    
    func bindLocaton(_ action: @escaping ((String) -> Void)) {
        self.setLocation = action
        setLocation?(defaultLocationButtonTitle)
    }
    
    func bindSunrise(_ action: @escaping ((String) -> Void)) {
        self.setSunrise = action
        setSunrise?(defaultText)
    }
    
    func bindSunset(_ action: @escaping ((String) -> Void)) {
        self.setSunset = action
        setSunset?(defaultText)
    }
    
    func bindTemperature(_ action: @escaping ((String) -> Void)) {
        self.setTemperature = action
        setTemperature?(defaultTemperatureText)
    }
    
    func bindWindspeed(_ action: @escaping ((String) -> Void)) {
        self.setWindSpeed = action
        setWindSpeed?(defaultText)
    }
    
    func bindCondition(_ action: @escaping ((String) -> Void)) {
        self.setCondition = action
        self.setCondition?("")
    }
    
    func bindWeatherIcon(_ action: @escaping ((String) -> Void)) {
        self.setWeatherIcon = action
    }
    
    // MARK: -
    
    /// Starts a process to check of the last location is stored and then retrieves the weather data for that location
    func weatherForLastLocation() async throws {
        guard let lastLocation = LocationResponse.lastLocation(), let lastUnit = Unit.lastUnit() else {
            throw NSError(domain: "LastLocationError", code: -1, userInfo: [NSLocalizedDescriptionKey : "Not found"])
        }
        do {
            try await self.getWeatherForLocation(lastLocation, unit: lastUnit)
        } catch {
            throw error
        }
    }
    
    /// Retrieves the weather for a given location
    /// - Parameters:
    ///   - location: `Location` object with the name, lat and lon to request weather data from
    ///   - unit: `Unit` value for either `.imperial` or `.metric` information in the returned data
    func getWeatherForLocation(_ location: LocationResponse, unit: Unit) async throws {
        DispatchQueue.main.async { [weak self] in
            self?.setLocation?(location.name)
        }
        do {
            let weatherResponse = try await ServiceController.getCurrentWeatherForLocation(location, unit: unit)
            DispatchQueue.main.async { [weak self] in
                self?.setWeatherFromResponse(weatherResponse, withUnit: unit)
            }
        } catch {
            throw error
        }
    }
    
    /// Updates the bound objects from the View Controller
    /// - Parameters:
    ///   - weatherResponse: the `WeatherResponse` model containing the weather data
    ///   - unit: `Unit` type to set accompanying unit measures to the data
    private func setWeatherFromResponse(_ weatherResponse: WeatherResponse, withUnit unit: Unit) {
        
        setSunrise?(weatherResponse.current.sunrise.formatDate(withOffset: Double(weatherResponse.timezoneOffset)))
        
        setSunset?(weatherResponse.current.sunset.formatDate(withOffset: Double(weatherResponse.timezoneOffset)))
        
        let tempUnit = unit == .imperial ? "℉" : "℃"
        let temp = Int(weatherResponse.current.temp)
        setTemperature?("\(temp)" + tempUnit)
        
        let speedUnit = unit == .imperial ? " mph" : " kph"
        let speed = Int(weatherResponse.current.windSpeed)
        setWindSpeed?("\(speed)" + speedUnit)
        
        guard let first = weatherResponse.current.weather.first else {
            return
        }
        let condition = first.main
        setCondition?(condition)
        Task {
            do {
                try await getImageNamed(first.icon)
            } catch {
                throw error
            }
        }
    }
    
    /// Retrieves the weather icon image if the icon is not currently in the image cache
    /// - Parameter name: the name id for the weather icon returned in the weather data
    private func getImageNamed(_ name: String) async throws {
        
        if ApplicationState.cachedImage(withId: name) != nil {
            DispatchQueue.main.async { [weak self] in
                self?.setWeatherIcon?(name)
            }
            return
        }
        
        do {
            let image = try await ImageController.getImageNamed(name)
            ApplicationState.addCachedImage(image, withId: name)
            DispatchQueue.main.async { [weak self] in
                self?.setWeatherIcon?(name)
            }
        } catch {
            print("\(error)")
        }
    }
}

extension WeatherViewModel: LocationSearchProtocol {
    
    func searchForLocation(_ location: String) async throws -> [LocationResponse] {
        do {
            let locations = try await ServiceController.getLatLonFromLocation(location)
            return locations
        } catch {
            print("\(error)")
            return [LocationResponse]()
        }
    }
    
    func getCurrentLocation() {
        // TODO: Implement LocationController
    }
}
