//
//  WeatherInfoIconView.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/21/23.
//

import UIKit

enum WeatherInfoIcon {
    case wind
    case sunrise
    case sunset
}

class WeatherInfoIconView: UIView {
    
    // MARK: - Parameters
    
    var weatherInfoIcon = WeatherInfoIcon.wind {
        didSet {
            iconImageView.image = UIImage(systemName: "\(weatherInfoIcon)")
            switch weatherInfoIcon {
            case .wind:
                iconImageView.tintColor = .systemGray
            case .sunrise, .sunset:
                iconImageView.tintColor = .systemYellow
            }
        }
    }
    
    var weatherInfoText = "" {
        didSet {
            weatherInfoLabel.text = weatherInfoText
        }
    }
    
    // MARK: - View components
    
    private let iconImageView = UIImageView()
    private let weatherInfoLabel = UILabel()

    // MARK: - Initializers
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
        
    private func configure() {
        setupSelf()
        setupIconImageView()
        setupWeatherInfoLabel()
    }
    
    private func setupSelf() {
        self.backgroundColor = UIColor(named: "WeatherInfoViewBackgroundColor")
        self.layer.cornerRadius = 3.0
        self.isOpaque = false
    }
    
    private func setupIconImageView() {
        self.addSubview(iconImageView)
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3.0),
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3.0),
            iconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3.0),
            iconImageView.widthAnchor.constraint(equalToConstant: 30.0)
        ])
    }
    
    private func setupWeatherInfoLabel() {
        self.addSubview(weatherInfoLabel)
        weatherInfoLabel.textAlignment = .right
        weatherInfoLabel.textColor = .white
        weatherInfoLabel.numberOfLines = 1
        weatherInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherInfoLabel.topAnchor.constraint(equalTo: self.topAnchor),
            weatherInfoLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor),
            weatherInfoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3.0),
            weatherInfoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
