//
//  LocationController.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation
import BuckarooBanzai
import CoreLocation

/// Controller used to get the device's current location
/// NOTE: This class is incomplete as I have not used CoreLocation in some time and I wanted to get the rest of the project completed
class LocationController: NSObject {
    
}

extension LocationController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Current: \(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error: \(error)")
    }
}
