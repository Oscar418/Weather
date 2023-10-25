//
//  WeatherCondition.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import Foundation

enum WeatherCondition {
    case none
    case sunny
    case cloudy
    case rainy

    init(stringValue: String) {
        switch stringValue {
        case "Clear":
            self = .sunny
        case "Clouds":
            self = .cloudy
        case "Rainy":
            self = .rainy
        default:
            self = .none
        }
    }
}
