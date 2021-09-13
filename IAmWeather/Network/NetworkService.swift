//
//  NetworkService.swift
//  IAmWeather
//
//  Created by Артем on 06.09.2021.
//

import UIKit

class NetworkService : NetworkManagerProtocol {
    
    func fetchWeather(lat: String, lon: String, completion: @escaping (Weather) -> ()) {
        let API_URL = "https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(lon)&extra=true"
        
        guard let url = URL(string: API_URL) else {
                 fatalError()
             }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(NetworkProperties.API_KEY, forHTTPHeaderField: "X-Yandex-API-Key")
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
            let currentWeather = try JSONDecoder().decode(Weather.self, from: data)
                completion(currentWeather)
            } catch {
                print(error)
            }
        }.resume()
    }
}
