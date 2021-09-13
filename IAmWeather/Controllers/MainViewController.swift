//
//  MainViewController.swift
//  IAmWeather
//
//  Created by Артем on 06.09.2021.
//

import UIKit

class MainViewController: UIViewController, UISearchResultsUpdating {
        
    var filteredCities = [City]()
    
    //MARK: - Content
    // Table with cities
    private lazy var citiesTableView = TableView(dataSource: self, delegate: self)
    let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredCities = Storage.cityTabel
        searchController.searchResultsUpdater = self
        searchController.definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        citiesTableView.tableHeaderView = searchController.searchBar
        view.backgroundColor = .white
        setupNavigationBar()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(citiesTableView)
        
        // MARK: Constraints
        let constraints = [
            citiesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            citiesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            citiesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            citiesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "IAm.Weather"
    
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refreshWeather))
        ]
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            filteredCities = Storage.cityTabel
        } else {
            filteredCities = Storage.cityTabel.filter { $0.title.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        self.citiesTableView.reloadData()
    }
    
    // MARK: - Actions
    @objc func refreshWeather() {
        citiesTableView.reloadData()
    }
    
}

// MARK: - Extensions
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as! TableViewCell
        let city = self.filteredCities[indexPath.row]
        
        cell.cityFromStorage = city
        
        cell.loadData(city: city)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        citiesTableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCity = filteredCities[indexPath.row]
        let cityDetailsController = CityDetailsViewController(city: selectedCity)
        
        navigationController?.pushViewController(cityDetailsController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
}


