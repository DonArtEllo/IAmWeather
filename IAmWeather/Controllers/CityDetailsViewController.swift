//
//  CityDetailsViewController.swift
//  IAmWeather
//
//  Created by Артем on 06.09.2021.
//

import UIKit

class CityDetailsViewController: UIViewController {
    
    let networkManager = NetworkService()
    private let selectedCity: City
    private lazy var forecastTableView = DetailedTableView(dataSource: self, delegate: self)
    private var currentWeatherText = "*current weather*"
    
    // MARK: - Initialization
    init(city: City) {
        self.selectedCity = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedCity.title
        view.backgroundColor = .lightGray
        setupViews()
        setupNavigationBar()
        loadCurrentWeather(city: selectedCity)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func setupViews() {
        view.addSubview(forecastTableView)
        
        // MARK: Constraints
        let constraints = [
            forecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forecastTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            forecastTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "IAm.Weather"
        self.navigationItem.backButtonDisplayMode = .minimal
    
        self.navigationItem.rightBarButtonItems = [
                UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .done, target: self, action: #selector(currentWeather)),
            UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refreshWeather))
        ]
    }
    
    func loadCurrentWeather(city: City) {
        networkManager.fetchWeather(lat: city.lat, lon: city.lon) { (weather) in
            
            
            DispatchQueue.main.async {
                self.currentWeatherText = """
                
                    Temperature: \(weather.fact.temp)°C.
                    Wind Speed: \(weather.fact.windSpeed) m/s.
                    Wind direction: \(weather.fact.windDir.capitalized)
                    Humidity: \(weather.fact.humidity)%
                    Sky condition: \(weather.fact.condition.capitalizingFirstLetter()).
                """
            }
            
        }
    }
    
    // MARK: - Actions
    @objc func currentWeather() {
        self.loadCurrentWeather(city: self.selectedCity)
        
        let alertController = UIAlertController(title: "Current Weather", message: "\(self.currentWeatherText)", preferredStyle: .alert)
         let saveAction = UIAlertAction(title: "Close", style: .default, handler: { alert -> Void in
         })
      
         alertController.addAction(saveAction)

         self.present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func refreshWeather() {
        forecastTableView.reloadData()
    }
    
    // MARK: - Animations
    
}

// MARK: - Extentions
extension CityDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: String(describing: DetailedTabelViewCell.self), for: indexPath) as! DetailedTabelViewCell
        let forecast = indexPath.row
        cell.city = selectedCity
        cell.day = forecast
        cell.loadForecast(city: selectedCity, day: forecast)
        return cell
    }
}

extension CityDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
}
