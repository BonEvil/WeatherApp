//
//  WeatherImageService.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation
import BuckarooBanzai

/// Service class to retrieve a wether image
class WeatherImageService: BaseWeatherService {
    
    required init(withImageId id: String) {
        super.init(withPath: "", needsAppId: false)
        
        self.requestURL = "https://openweathermap.org/img/wn/\(id)@2x.png"
        self.acceptType = .ANY
    }
}
