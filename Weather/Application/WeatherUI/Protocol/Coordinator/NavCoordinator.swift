//
//  NavCoordinator.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

protocol NavCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
}

extension NavCoordinator {
    func setRootViewController(_ viewController: UIViewController, animated: Bool = false) {
        navigationController.setRootViewController(viewController)
    }

    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }
}
