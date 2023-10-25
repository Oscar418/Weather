//
//  ForecastWeather.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import Foundation

struct ForecastWeather: Codable, Equatable {
    let list: [WeatherInfo]

    static func == (lhs: ForecastWeather, rhs: ForecastWeather) -> Bool {
        return lhs.list == rhs.list
    }
}

struct WeatherInfo: Codable, Equatable {
    let date: TimeInterval
    let main: WeatherInfoData
    let weather: [Weather]
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
        case dtTxt = "dt_txt"
    }

    static func == (lhs: WeatherInfo, rhs: WeatherInfo) -> Bool {
        return lhs.date == rhs.date && lhs.main == rhs.main && lhs.weather == rhs.weather && lhs.dtTxt == rhs.dtTxt
    }
}
