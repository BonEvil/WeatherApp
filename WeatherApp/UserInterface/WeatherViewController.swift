//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import UIKit
import SwiftUI

/// The main View Controller for the application
/// Uses a modelView for business logic
class WeatherViewController: UIViewController {
    
    let viewModel = WeatherViewModel()
    
    @IBOutlet weak var locationButton: UIButton! {
        didSet {
            viewModel.bindLocaton { [weak self] location in
                self?.locationButton.setTitle(location, for: .normal)
            }
        }
    }
    @IBOutlet weak var temperatureLabel: UILabel! {
        didSet {
            viewModel.bindTemperature { [weak self] text in
                self?.temperatureLabel.text = text
            }
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.backgroundColor = UIColor(named: "WeatherIconBackgroundColor")
            iconImageView.layer.cornerRadius = 10.0
            viewModel.bindWeatherIcon { [weak self] name in
                self?.iconImageView.image = ApplicationState.cachedImage(withId: name)
            }
        }
    }
    
    @IBOutlet weak var conditionLabel: UILabel! {
        didSet {
            viewModel.bindCondition { [weak self] text in
                self?.conditionLabel.text = text
            }
        }
    }
    
    @IBOutlet weak var windInfoView: WeatherInfoIconView! {
        didSet {
            windInfoView.weatherInfoIcon = .wind
            viewModel.bindWindspeed { [weak self] text in
                self?.windInfoView.weatherInfoText = text
            }
        }
    }
    
    @IBOutlet weak var sunriseInfoView: WeatherInfoIconView! {
        didSet {
            sunriseInfoView.weatherInfoIcon = .sunrise
            viewModel.bindSunrise { [weak self] text in
                self?.sunriseInfoView.weatherInfoText = text
            }
        }
    }
    
    @IBOutlet weak var sunsetInfoView: WeatherInfoIconView! {
        didSet {
            sunsetInfoView.weatherInfoIcon = .sunset
            viewModel.bindSunset { [weak self] text in
                self?.sunsetInfoView.weatherInfoText = text
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        weatherForLastLocation()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if locationButton == sender {
            
            let locationSearchView = LocationSearchView(placeProtocol: self.viewModel) { [weak self] in
                self?.dismiss(animated: true)
                self?.weatherForLastLocation()
            }

            self.present(UIHostingController(rootView: locationSearchView), animated: true)
        }
    }
    
    private func weatherForLastLocation() {
        Task {
            do {
                try await viewModel.weatherForLastLocation()
            } catch {
                // TODO: get location and set weather
                print("\(error)")
            }
        }
    }
}
