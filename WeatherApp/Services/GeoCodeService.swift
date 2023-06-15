//
//  GeoCodeService.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation
import BuckarooBanzai

class GeoCodeService: BaseWeatherService {
    
    required init(withPlace place: String) {
        super.init(withPath: "/geo/1.0/direct?q=\(place)&limit=5")
    }
}
