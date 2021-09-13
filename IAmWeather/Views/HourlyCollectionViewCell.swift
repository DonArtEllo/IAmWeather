//
//  HourlyCollectionViewCell.swift
//  IAmWeather
//
//  Created by Артем on 11.09.2021.
//

import UIKit
import SVGWebRenderer

class HourlyCollectionViewCell: UICollectionViewCell {
    
    let networkManager = NetworkService()
    
    // MARK: - Content
    // Forecast time label
    let hourlyTimeLabel: UILabel = {
       let hourlyTimeLabel = UILabel()
        hourlyTimeLabel.text = "05:00"
        hourlyTimeLabel.font = UIFont.systemFont(ofSize: 8)
        hourlyTimeLabel.textAlignment = .center
        hourlyTimeLabel.textColor = .label
        
        hourlyTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return hourlyTimeLabel
    }()
    
    // Forecast image
    let temperatureSymbol: UIImageView = {
       let temperatureSymbol = UIImageView()
        temperatureSymbol.contentMode = .scaleAspectFit
        temperatureSymbol.backgroundColor = .lightGray
        
        temperatureSymbol.translatesAutoresizingMaskIntoConstraints = false
        return temperatureSymbol
    }()
    
    // Forecast temperature label
    let temperatureLabel: UILabel = {
       let temperatureLabel = UILabel()
        temperatureLabel.text = "05:00"
        temperatureLabel.font = UIFont.systemFont(ofSize: 12)
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .label
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.systemBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        setupViews()
     }
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func setupViews() {
        addSubviews(
            hourlyTimeLabel,
            temperatureSymbol,
            temperatureLabel
        )
    
        // MARK: Conctraints
        let constraints = [
            hourlyTimeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            hourlyTimeLabel.heightAnchor.constraint(equalToConstant: 10),
            hourlyTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            hourlyTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        
            temperatureSymbol.topAnchor.constraint(equalTo: hourlyTimeLabel.bottomAnchor, constant: 6),
            temperatureSymbol.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureSymbol.heightAnchor.constraint(equalToConstant: 30),
            temperatureSymbol.widthAnchor.constraint(equalToConstant: 30),
        
            temperatureLabel.topAnchor.constraint(equalTo: temperatureSymbol.bottomAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func loadHourForecast(city: City, day: Int, time: Int) {
        networkManager.fetchWeather(lat: city.lat, lon: city.lon) { (weather) in
            var currentHour = weather.forecasts[day].parts.day
            
            DispatchQueue.main.async {
                switch time {
                    case 0 :
                        currentHour = weather.forecasts[day].parts.morning
                        self.hourlyTimeLabel.text = "Morning"
                    case 1 :
                        currentHour = weather.forecasts[day].parts.day
                        self.hourlyTimeLabel.text = "Day"
                    case 2 :
                        currentHour = weather.forecasts[day].parts.evening
                        self.hourlyTimeLabel.text = "Evening"
                    case 3 :
                        currentHour = weather.forecasts[day].parts.night
                        self.hourlyTimeLabel.text = "Morning"
                                
                    default :
                        print("Error. Wrong time of the day")
                }
                self.temperatureSymbol.setImage(URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(currentHour.icon).svg"), placeholder: nil)
                self.temperatureLabel.text = String(currentHour.tempAvg) + "°C"
            }
            
        }
    }
}
