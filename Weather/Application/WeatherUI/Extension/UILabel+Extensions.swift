//
//  UILabel+Extensions.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/24.
//

import UIKit

extension UILabel {
    func configureLabel(_ configure: (UILabel) -> Void) -> UILabel {
        configure(self)
        return self
    }
}
