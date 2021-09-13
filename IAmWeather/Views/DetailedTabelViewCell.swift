//
//  DetailedTabelViewCell.swift
//  IAmWeather
//
//  Created by Артем on 11.09.2021.
//

import UIKit
import GIFImageView

final class DetailedTabelViewCell: UITableViewCell {
    
    let networkManager = NetworkService()
    var forecastCity: City = Storage.cityTabel[0]
    var forecastDay: Int = 0
    var forecastHours: Int = 24
    
    // MARK: Data from Storage
    var city: City? {
        didSet {
            if let city = city {
                self.forecastCity = city
            }
        }
    }
    var day: Int? {
        didSet {
            if let day = day {
                self.forecastDay = day
            }
        }
    }

    // MARK: - Content
    // Label for day of forecast
    let weekdaylabel: UILabel = {
       let weekdaylabel = UILabel()
        weekdaylabel.text = "01.01"
        weekdaylabel.textColor = .label
        weekdaylabel.translatesAutoresizingMaskIntoConstraints = false
        return weekdaylabel
    }()
    
    // Collection of hourly forecast
    var hourlyCollectionView : UICollectionView!
    

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        hourlyCollectionView = UICollectionView(frame: CGRect(x: 100, y: 0, width: (frame.width - 112), height: frame.height), collectionViewLayout: createCompositionalLayout())
        hourlyCollectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HourlyCollectionViewCell.self))
        hourlyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        hourlyCollectionView.backgroundColor = .systemBackground
        hourlyCollectionView.delegate = self
        hourlyCollectionView.dataSource = self
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    // Setup views
    func setupViews() {
        
        contentView.addSubviews(
            weekdaylabel,
            hourlyCollectionView
        )
        
        hourlyCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hourlyCollectionView.backgroundColor = .systemBackground
        
        let contentViewHeight = contentView.heightAnchor.constraint(equalToConstant: (superview?.bounds.height ?? 800) / 8.25)
        contentViewHeight.priority = .defaultHigh
        
        // MARK: Constrains
        let constraints = [
            contentViewHeight,
            
            weekdaylabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            weekdaylabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            weekdaylabel.heightAnchor.constraint(equalToConstant: 30),
            weekdaylabel.widthAnchor.constraint(equalToConstant: 100),

            hourlyCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hourlyCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hourlyCollectionView.leadingAnchor.constraint(equalTo: weekdaylabel.trailingAnchor, constant: 16),
            hourlyCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func loadForecast(city: City, day: Int) {
        networkManager.fetchWeather(lat: city.lat, lon: city.lon) { (weather) in
            let hours = weather.forecasts[day].hours.count

            DispatchQueue.main.async {
                self.weekdaylabel.text = weather.forecasts[day].date
                self.forecastHours = hours
            }
            
        }
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            self.createFeaturedSection()
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        return layout
    }
        
    func createFeaturedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(0.75))

       let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
       layoutItem.contentInsets = NSDirectionalEdgeInsets(top:5, leading: 5, bottom: 0, trailing: 5)

       let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(110))
       let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

       let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
       layoutSection.orthogonalScrollingBehavior = .groupPagingCentered

       return layoutSection
    }
    
}

// MARK: - Extentions
extension DetailedTabelViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HourlyCollectionViewCell.self), for: indexPath) as! HourlyCollectionViewCell
        let forecastTime = indexPath.row
        cell.loadHourForecast(city: forecastCity, day: forecastDay, time: forecastTime)

        return cell
    }
    
    
}

extension DetailedTabelViewCell: UICollectionViewDataSource {
    
}
