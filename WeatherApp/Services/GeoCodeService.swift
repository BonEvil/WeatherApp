//
//  GeoCodeService.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation
import BuckarooBanzai

/// Service class to retrieve geocodes for the given place query
class GeoCodeService: BaseWeatherService {
    
    required init(withPlace place: String) {
        super.init(withPath: "/geo/1.0/direct?q=\(place.urlEncode())&limit=10")
    }
}
