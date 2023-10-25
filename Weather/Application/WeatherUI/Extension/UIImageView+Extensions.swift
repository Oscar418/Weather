//
//  UIImageView+Extensions.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/24.
//

import UIKit

extension UIImageView {
    func configureImageView(_ configure: (UIImageView) -> Void) -> UIImageView {
        configure(self)
        return self
    }
}
