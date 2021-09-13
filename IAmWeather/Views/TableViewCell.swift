//
//  TableViewCell.swift
//  IAmWeather
//
//  Created by Артем on 06.09.2021.
//

import UIKit
import SVGWebRenderer

final class TableViewCell: UITableViewCell {
    
    let networkManager = NetworkService()
    
    // MARK: Data from Storage
    var cityFromStorage: City? {
        didSet {
            cityNameLabel.text = cityFromStorage?.title
            if let city = cityFromStorage {
                currentCity = city
            }
        }
    }
    
    var currentCity = Storage.cityTabel[0]
    
    // MARK: - Content
    // Label for city name
    private let cityNameLabel: UILabel = {
        let cityNameLabel = UILabel()
        cityNameLabel.text = "CityName"
        
        return cityNameLabel
    }()

    // Label for temperature
    private let cityCurrentTemperature: UILabel = {
        let cityCurrentTemperature = UILabel()
        cityCurrentTemperature.text = "25°C"
        
        return cityCurrentTemperature
    }()
    
    // Image of current weather
    private let cityWeatherImage: UIImageView = {
        let cityWeatherImage = UIImageView()
        let weaterImage = UIImage.animatedImage(named: "sun")
        cityWeatherImage.image = weaterImage
        
        return cityWeatherImage
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    // Setup views
    func setupViews() {
        
        contentView.addSubviews(
            cityNameLabel,
            cityCurrentTemperature,
            cityWeatherImage
        )
        
        let contentViewHeight = contentView.heightAnchor.constraint(equalToConstant: (superview?.bounds.height ?? 800) / 11.25)
        contentViewHeight.priority = .defaultHigh
        
        // MARK: Constrains
        let constraints = [
            contentViewHeight,
            
            cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cityNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            
            cityCurrentTemperature.topAnchor.constraint(equalTo: cityNameLabel.topAnchor),
            cityCurrentTemperature.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cityCurrentTemperature.bottomAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
            
            cityWeatherImage.centerYAnchor.constraint(equalTo: cityNameLabel.centerYAnchor),
            cityWeatherImage.heightAnchor.constraint(equalToConstant: 50),
            cityWeatherImage.widthAnchor.constraint(equalToConstant: 50),
            cityWeatherImage.trailingAnchor.constraint(equalTo: cityCurrentTemperature.leadingAnchor, constant: -32)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func loadData(city: City) {
        networkManager.fetchWeather(lat: city.lat, lon: city.lon) { (weather) in
            print("Current weather in city \(city.title) is \(weather.fact.temp)°C")
            print(weather.fact.icon)
            
            DispatchQueue.main.async {
                self.cityCurrentTemperature.text = "\(weather.fact.temp)°C"
                self.cityWeatherImage.setImage(URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weather.fact.icon).svg"),
                                               placeholder: nil)
//              icon == bkn_n.svg - !does not work!
                
            }
        }
    }
}
