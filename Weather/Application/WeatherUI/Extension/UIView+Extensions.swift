//
//  UIView+Extensions.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/24.
//

import UIKit

extension UIView {
    func configureView(_ configure: (UIView) -> Void) -> UIView {
        configure(self)
        return self
    }
}
