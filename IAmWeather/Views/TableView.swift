//
//  TableView.swift
//  IAmWeather
//
//  Created by Артем on 06.09.2021.
//

import UIKit

final class TableView: UITableView {
    
    // MARK: - Initialization
    init(dataSource: UITableViewDataSource,
         delegate: UITableViewDelegate) {
        super.init(frame: .zero, style: .plain)
        
        self.dataSource = dataSource
        self.delegate = delegate
        
        translatesAutoresizingMaskIntoConstraints = false
        register(TableViewCell.self, forCellReuseIdentifier: String(describing: TableViewCell.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
