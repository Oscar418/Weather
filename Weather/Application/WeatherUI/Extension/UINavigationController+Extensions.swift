//
//  UINavigationController+Extensions.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

extension UINavigationController {
    func setRootViewController(_ viewController: UIViewController, animated: Bool = false) {
        setViewControllers([viewController], animated: animated)
    }

    func hideNavBar(animated: Bool = false) {
        setNavigationBarHidden(true, animated: animated)
    }

    func showNavBar(animated: Bool = false) {
        setNavigationBarHidden(false, animated: animated)
    }
}
