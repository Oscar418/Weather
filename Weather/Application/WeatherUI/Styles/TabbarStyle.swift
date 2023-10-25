//
//  TabbarStyle.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

extension UITabBarController: Styleable { }

enum TabBarStyle {
    static let weather: Style<UITabBarController> = {
        $0.tabBar.layer.masksToBounds = true
        $0.tabBar.isTranslucent = true
        $0.tabBar.tintColor = WeatherAsset.Color.black.color
        $0.tabBar.barTintColor = WeatherAsset.Color.lightGrey.color
        $0.tabBar.backgroundColor = WeatherAsset.Color.lightGrey.color
        $0.tabBar.layer.cornerRadius = 8
        $0.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
