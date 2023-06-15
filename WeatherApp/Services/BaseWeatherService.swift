//
//  BaseWeatherService.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation
import BuckarooBanzai

class BaseWeatherService: Service {
    var requestMethod: HTTPRequestMethod = .GET
    var acceptType: HTTPAcceptType = .JSON
    var timeout: TimeInterval = 10
    var requestURL: String = "https://api.openweathermap.org"
    var contentType: HTTPContentType?
    var requestBody: Data?
    var parameters: [AnyHashable : Any]?
    var additionalHeaders: [AnyHashable : Any]?
    var requestSerializer: RequestSerializer?
    var sessionDelegate: URLSessionTaskDelegate?
    var testResponse: HTTPResponse?
    
    var needsAppId: Bool = true
    
    init(withPath path: String, needsAppId: Bool = true) {
        self.requestURL = self.requestURL + path
        if needsAppId {
            guard let appId = Bundle.main.object(forInfoDictionaryKey: "OPEN_WEATHER_APP_ID") as? String else { return }
            self.requestURL = self.requestURL + "&appid=\(appId)"
        }
    }
}
