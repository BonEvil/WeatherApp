//
//  WeatherProtocol.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

protocol WeatherProtocol {
    func getWeatherForLocation(_ location: Location, unit: Unit) async throws
}
