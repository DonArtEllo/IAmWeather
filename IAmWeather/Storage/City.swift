//
//  City.swift
//  IAmWeather
//
//  Created by Артем on 06.09.2021.
//

public struct City {
    
    public let title: String
    public let lat: String
    public let lon: String
    
    public init(title: String, lat: String, lon: String) {
        
        self.title = title
        self.lat = lat
        self.lon = lon
    }

}
