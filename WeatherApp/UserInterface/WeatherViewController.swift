//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let viewModel = WeatherViewModel()
    
    @IBOutlet weak var searchLocationButton: UIButton!
    @IBOutlet weak var locationButton: UIButton! {
        didSet {
            locationButton.setTitle("Find Location", for: .normal)
            viewModel.bindLocaton { [weak self] location in
                DispatchQueue.main.async {
                    self?.locationButton.setTitle(location, for: .normal)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.bindSunset { time in
            print(time)
        }
        
        viewModel.bindSunrise { time in
            print(time)
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if locationButton == sender {
            // TODO: show location search view
            
            Task {
                do {
                    let locationResponses = try await viewModel.searchForPlace(Place(city: "London", state: ""))
                    guard let first = locationResponses.first else {
                        return
                    }
                    print("\(first)")
                    let name = first.name + ", " + first.state
                    try await viewModel.getWeatherForLocation(Location(name: name ,lat: first.lat, lon: first.lon), unit: .imperial)
                } catch {
                    print("\(error)")
                }
            }
        }
        
        if searchLocationButton == sender {
            // TODO: location search
        }
    }
}
