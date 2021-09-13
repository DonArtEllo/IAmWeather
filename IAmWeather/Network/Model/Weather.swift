//
//  Weather.swift
//  IAmWeather
//
//  Created by Артем on 06.09.2021.
//

import Foundation

// MARK: - Weather
struct Weather: Decodable {
    let now: Int
    let nowDt: String
    let info: Info
    let fact: Fact
    let forecasts: [Forecast]

    enum CodingKeys: String, CodingKey {
        case now
        case nowDt = "now_dt"
        case info, fact, forecasts
    }
}

// MARK: - Fact
struct Fact: Decodable {
    let temp, feelsLike: Int
    let icon, condition: String
    let windSpeed: Double
    let windGust: Double
    let windDir: String
    let pressureMm, pressurePa, humidity: Int
    let daytime: String
    let polar: Bool
    let season: String
    let precType: Int
    let precStrength: Double
    let isThunder: Bool
    let cloudness: Double
    let obsTime: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case icon, condition
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case pressurePa = "pressure_pa"
        case humidity, daytime, polar, season
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case isThunder = "is_thunder"
        case cloudness
        case obsTime = "obs_time"
    }
}

// MARK: - Forecast
struct Forecast: Codable {
    let date: String
    let dateTs, week: Int
    let sunrise, sunset: String
    let moonCode: Int
    let moonText: String
    let parts: Parts
    let hours: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case dateTs = "date_ts"
        case week, sunrise, sunset
        case moonCode = "moon_code"
        case moonText = "moon_text"
        case parts, hours
    }
}

// MARK: - Hour
struct Hour: Codable {
    let hour: String
    let hourTs, temp, feelsLike: Int
    let icon, condition: String
    let windSpeed, windGust: Double
    let windDir: String
    let pressureMm, pressurePa, humidity: Int
    let precMm: Double
    let precPeriod, precType: Int
    let precStrength: Double
    let isThunder: Bool
    let cloudness: Double

    enum CodingKeys: String, CodingKey {
        case hour
        case hourTs = "hour_ts"
        case temp
        case feelsLike = "feels_like"
        case icon, condition
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case pressurePa = "pressure_pa"
        case humidity
        case precMm = "prec_mm"
        case precPeriod = "prec_period"
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case isThunder = "is_thunder"
        case cloudness
    }
}

// MARK: - Parts
struct Parts: Codable {
    let morning, day, night, evening: DayTime
    let dayShort, nightShort: Short

    enum CodingKeys: String, CodingKey {
        case morning, day, night, evening
        case dayShort = "day_short"
        case nightShort = "night_short"
    }
}

// MARK: - Short
struct Short: Codable {
    let temp: Int
    let tempMin: Int?
    let feelsLike: Int
    let icon, condition: String
    let windSpeed, windGust: Double
    let windDir: String
    let pressureMm, pressurePa, humidity, precType: Int
    let precStrength, cloudness: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case feelsLike = "feels_like"
        case icon, condition
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case pressurePa = "pressure_pa"
        case humidity
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case cloudness
    }
}

// MARK: - DayTime
struct DayTime: Codable {
    let tempMin, tempMax, tempAvg, feelsLike: Int
    let icon, condition, daytime: String
    let polar: Bool
    let windSpeed: Double
    let windDir: String
    let pressureMm, pressurePa, humidity: Int
    let precMm: Double
    let precPeriod, precType: Int
    let precStrength, cloudness: Double
    let windGust: Double?

    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempAvg = "temp_avg"
        case feelsLike = "feels_like"
        case icon, condition, daytime, polar
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case pressurePa = "pressure_pa"
        case humidity
        case precMm = "prec_mm"
        case precPeriod = "prec_period"
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case cloudness
        case windGust = "wind_gust"
    }
}

// MARK: - Info
struct Info: Codable {
    let lat, lon: Double
    let tzinfo: Tzinfo
    let defPressureMm, defPressurePa: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case lat, lon, tzinfo
        case defPressureMm = "def_pressure_mm"
        case defPressurePa = "def_pressure_pa"
        case url
    }
}

// MARK: - Tzinfo
struct Tzinfo: Codable {
    let offset: Int
    let name, abbr: String
    let dst: Bool
}
