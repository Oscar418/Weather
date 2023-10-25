//
//  HomeCoordinator.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

class HomeCoordinator: NavCoordinator {

    let navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [String: Coordinator] = [ : ]

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.tabBarItem = UITabBarItem(TabItemStyle.weather(title: "",
                                                                            icon: WeatherAsset.Image.homeIcon.image))
        navigationController.hideNavBar()
        let homeVC = HomeViewController(viewModel: HomeViewModel(coordinator: self))
        navigationController.setRootViewController(homeVC)
    }
}
