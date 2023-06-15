//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

class WeatherViewModel {
    
    let defaultLocationButtonTitle = "Set Location"
    let defaultTemperatureText = "--°"
    let defaultText = "--"
    
    private var lastLocation: Location? = UserDefaults.standard.object(forKey: "lastLocation") as? Location {
        didSet {
            guard let lastLocation = lastLocation else {
                UserDefaults.standard.removeObject(forKey: "lastLocation")
                return
            }
            let location = ["name": lastLocation.name, "lat": "\(lastLocation.lat)", "lon": "\(lastLocation.lon)"]
            UserDefaults.standard.set(location, forKey: "lastLocation")
        }
    }
    private var lastUnit: Unit? = UserDefaults.standard.object(forKey: "lastUnit") as? Unit {
        didSet {
            guard let lastUnit = lastUnit else {
                UserDefaults.standard.removeObject(forKey: "lastUnit")
                return
            }
            UserDefaults.standard.set("\(lastUnit)", forKey: "lastUnit")
        }
    }
    
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
    
    func weatherForLastLocation() async throws {
        guard let location = UserDefaults.standard.object(forKey: "lastLocation") as? [String:String],
              let unit = UserDefaults.standard.object(forKey: "lastUnit") as? String else {
            throw NSError(domain: "weatherViewModelDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "No last location"])
        }
        
        guard let name = location["name"], let lon = location["lon"], let lat = location["lat"], let lonFloat = Float(lon), let latFloat = Float(lat) else {
            self.lastUnit = nil
            self.lastLocation = nil
            throw NSError(domain: "weatherViewModelDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not parse last location from user defaults"])
        }

        let lastLocation = Location(name: name, lat: latFloat, lon: lonFloat)
        let lastUnit = unit == "imperial" ? Unit.imperial : Unit.metric
        do {
            try await self.getWeatherForLocation(lastLocation, unit: lastUnit)
        } catch {
            throw error
        }
    }
    
    func getWeatherForLocation(_ location: Location, unit: Unit) async throws {
        self.lastLocation = location
        self.lastUnit = unit
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
    
    private func setWeatherFromResponse(_ weatherResponse: WeatherResponse, withUnit unit: Unit) {
        print("\(weatherResponse)")
        
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
    
    func getImageNamed(_ name: String) async throws {
        
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

extension WeatherViewModel: PlaceProtocol {
    
    func searchForPlace(_ place: String) async throws -> [LocationResponse] {
        do {
            let locations = try await ServiceController.getLatLonFromPlace(place)
            return locations
        } catch {
            throw error
        }
    }
    
    func onSelect(_ location: Location, _ unit: Unit) {
        Task {
            do {
                try await self.getWeatherForLocation(location, unit: unit)
            } catch {
                print("\(error)")
            }
        }
    }
    
    func getCurrentLocation() {
        let locationController = LocationController()
        Task {
            do {
                let _ = try await locationController.getCurrentLocation()
            } catch {
                print("\(error)")
            }
        }
    }
}
