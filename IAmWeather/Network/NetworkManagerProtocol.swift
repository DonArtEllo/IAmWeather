//
//  NetworkManagerProtocol.swift
//  IAmWeather
//
//  Created by Артем on 11.09.2021.
//

import UIKit

protocol NetworkManagerProtocol {
    
    func fetchWeather(lat: String, lon: String, completion: @escaping (Weather) -> ())
}
