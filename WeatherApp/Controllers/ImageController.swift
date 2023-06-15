//
//  ImageController.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation
import UIKit
import BuckarooBanzai

/// Controller to make network calls to retrieve associated weather images
struct ImageController {
    
    static func getImageNamed(_ name: String) async throws -> UIImage {
        let service = WeatherImageService(withImageId: name)
        do {
            let response = try await BuckarooBanzai.shared.start(service: service)
            let image = try response.decodeBodyDataAsImage()
            return image
        } catch {
            throw error
        }
    }
}
