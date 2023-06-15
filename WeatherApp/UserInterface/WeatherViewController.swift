//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/14/23.
//

import UIKit
import SwiftUI

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
    
    @IBOutlet weak var windLabel: UILabel! {
        didSet {
            viewModel.bindWindspeed { [weak self] text in
                self?.windLabel.text = text
            }
        }
    }
    
    @IBOutlet weak var sunriseLabel: UILabel! {
        didSet {
            viewModel.bindSunrise { [weak self] text in
                self?.sunriseLabel.text = text
            }
        }
    }
    
    @IBOutlet weak var sunsetLabel: UILabel! {
        didSet {
            viewModel.bindSunset { [weak self] text in
                self?.sunsetLabel.text = text
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task {
            do {
                try await viewModel.weatherForLastLocation()
            } catch {
                // TODO: get location and set weather
                print("\(error)")
            }
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if locationButton == sender {
            let placeSelection = PlaceSelectionView(placeProtocol: self.viewModel) { [weak self] in
                self?.dismiss(animated: true)
            }
            self.present(UIHostingController(rootView: placeSelection), animated: true)
        }
    }
}
