//
//  UIStackView+Extensions.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

extension UIStackView {
    func configureStackView(_ configure: (UIStackView) -> Void) -> UIStackView {
        configure(self)
        return self
    }

    func addArrangedSubview(_ subviews: UIView...) {
        subviews.forEach {
            addArrangedSubview($0)
        }
    }

    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { allSubviews, subview -> [UIView] in
            return allSubviews + [subview]
        }

        for view in removedSubviews where view.superview != nil {
            NSLayoutConstraint.deactivate(view.constraints)
            view.removeFromSuperview()
        }
    }
}
