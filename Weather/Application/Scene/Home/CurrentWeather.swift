//
//  CurrentWeather.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import Foundation

struct CurrentWeather: Codable, Equatable {
    let weather: [Weather]
    let main: WeatherInfoData
    let date: TimeInterval

    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case date = "dt"
    }

    static func == (lhs: CurrentWeather, rhs: CurrentWeather) -> Bool {
        return lhs.weather == rhs.weather && lhs.main == rhs.main && lhs.date == rhs.date
    }
}

struct Weather: Codable, Equatable {
    let main: String
    let description: String

    static func == (lhs: Weather, rhs: Weather) -> Bool {
        return lhs.main == rhs.main && lhs.description == rhs.description
    }
}

struct WeatherInfoData: Codable, Equatable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case feelsLike = "feels_like"
    }

    static func == (lhs: WeatherInfoData, rhs: WeatherInfoData) -> Bool {
        return lhs.temp == rhs.temp
        && lhs.feelsLike == rhs.feelsLike
        && lhs.tempMin == rhs.tempMin
        && lhs.tempMax == rhs.tempMax
    }
}
