//
//  Storage.swift
//  IAmWeather
//
//  Created by Артем on 11.09.2021.
//

import UIKit

public struct Storage {
    
    //MARK: Cities Data
    public static let cityTabel = [
        
        City(
            title: "Moscow",
            lat: "55.75222",
            lon: "37.61556"
        ),
        City(
            title: "New York",
            lat: "40.71427",
            lon: "-74.00597"
        ),
        City(
            title: "Tokyo",
            lat: "35.6895",
            lon: "139.69171"
        ),
        City(
            title: "London",
            lat: "55.75396",
            lon: "37.620393"
        ),
        City(
            title: "Los Angeles",
            lat: "34.05223",
            lon: "-118.24368"
        ),
        City(
            title: "Barcelona",
            lat: "41.38879",
            lon: "2.15899"
        ),
        City(
            title: "Saint Petersburg",
            lat: "59.93863",
            lon: "30.31413"
        ),
        City(
            title: "Toronto",
            lat: "43.70011",
            lon: "-79.4163"
        ),
        City(
            title: "San Francisco",
            lat: "37.77493",
            lon: "-122.41942"
        ),
        City(
            title: "Brooklyn",
            lat: "40.6501",
            lon: "-73.94958"
        )
    ]
    
    public static let weatherIcons = [
        "clear" : "sun",
        "partly-cloud" : "light-rain-cloud",
        "cloudy" : "partly-cloudy-day",
        "overcast" : "windy-weather",
        "drizzle" : "windy-weather",
        "light-rain" : "light-rain-cloud",
        "rain" : "rain-cloud",
        "moderate-rain" : "rain",
        "heavy-rain" : "rain",
        "continuous-heavy-rain" : "torrential-rain",
        "showers" : "storm",
        "wet-snow" : "light-snow",
        "light-snow" : "light-snow",
        "snow" : "snow-storm",
        "snow-showers" : "snow-storm",
        "hail" : "storm",
        "thunderstorm" : "lightning-bolt",
        "thunderstorm-with-rain" : "storm",
        "thunderstorm-with-hail" : "storm",
    ]
        
}
