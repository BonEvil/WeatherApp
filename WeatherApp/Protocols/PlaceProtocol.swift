//
//  PlaceProtocol.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation

protocol PlaceProtocol {
    func searchForPlace(_ place: Place) async throws -> [LocationResponse]
}
