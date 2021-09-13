//
//  DetailedTableView.swift
//  IAmWeather
//
//  Created by Артем on 11.09.2021.
//

import UIKit

final class DetailedTableView: UITableView {
    
    // MARK: - Initialization
    init(dataSource: UITableViewDataSource,
         delegate: UITableViewDelegate) {
        super.init(frame: .zero, style: .plain)
        
        self.dataSource = dataSource
        self.delegate = delegate
        
        translatesAutoresizingMaskIntoConstraints = false
        register(DetailedTabelViewCell.self, forCellReuseIdentifier: String(describing: DetailedTabelViewCell.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
