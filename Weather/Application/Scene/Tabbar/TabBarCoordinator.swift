//
//  TabBarCoordinator.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

enum AppTab {
    static let home = 0
    static let faves = 1
}

protocol TabBarCoordinatorType: Coordinator {
    var tabBarController: UITabBarController { get }
}

class TabBarCoordinator: TabBarCoordinatorType {

    let tabBarController = UITabBarController(TabBarStyle.weather)
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [String: Coordinator] = [ : ]

    var activeIndex: Int {
        return tabBarController.selectedIndex
    }

    private let homeCoordinator = HomeCoordinator()
    private let searchCoordinator = FavCoordinator()

    static let shared = TabBarCoordinator()

    func start() {
        let coordinators: [NavCoordinator] = [homeCoordinator,
                                              searchCoordinator]
        coordinators.forEach { coordinator in
            childCoordinators[coordinator.identifier] = coordinator
            coordinator.parentCoordinator = self
            coordinator.start()
        }

        let navigationControllers = coordinators.map { coordinator -> UINavigationController in
            coordinator.navigationController
        }

        tabBarController.setViewControllers(navigationControllers, animated: false)
        tabBarController.selectedIndex = AppTab.home
    }
}
