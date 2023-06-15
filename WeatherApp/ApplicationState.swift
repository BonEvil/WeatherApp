//
//  ApplicationState.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import Foundation
import UIKit

/// This is currently only using an ephemeral state for caching
/// Other global application state variables could be added here
struct ApplicationState {
    
    // MARK: - Images
    
    struct ImageItem {
        let id: String
        let image: UIImage
    }
    
    static let queue = DispatchQueue(label: "thread-safe-array")
    
    /// Simple image cache to limit network calls
    private static var imageCache: [ImageItem] = [ImageItem]()
    
    static func addCachedImage(_ image: UIImage, withId id: String) {
        if cachedImage(withId: id) != nil {
            return
        }
        queue.async {
            imageCache.append(ImageItem(id: id, image: image))
        }
    }
    
    static func cachedImage(withId id: String) -> UIImage? {
        queue.sync {
            guard let imageItem = imageCache.first(where: { item in
                item.id == id
            }) else {
                return nil
            }
            
            return imageItem.image
        }
    }
    
    static func clearCachedImages() {
        imageCache.removeAll()
    }
}
