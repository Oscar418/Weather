//
//  TabItemStyle.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

extension UITabBarItem: Styleable { }

enum TabItemStyle {
    static func weather(title: String, icon: UIImage) -> Style<UITabBarItem> {
        return {
            $0.title = title
            $0.image = icon
            $0.selectedImage = icon
        }
    }
}
