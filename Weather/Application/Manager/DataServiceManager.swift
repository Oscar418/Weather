//
//  DataServiceManager.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/24.
//

import UIKit

final class DataServiceManager {

    static let shared = DataServiceManager()

    var backgroundColor: UIColor = WeatherAsset.Color.sunny.color

    func setBackgroundColor(color: UIColor) {
        backgroundColor = color
    }

    func getBackgroundColor() -> UIColor {
        backgroundColor
    }
}
