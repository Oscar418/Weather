//
//  FavCoordinator.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit
import CoreLocation

class FavCoordinator: NavCoordinator {

    let navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [String: Coordinator] = [ : ]

    private lazy var favViewController: FavViewController = {
        let viewModel = FavViewModel(coordinator: self)
        return FavViewController(viewModel: viewModel)
    }()

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.tabBarItem = UITabBarItem(TabItemStyle.weather(title: "",
                                                                            icon: WeatherAsset.Image.favIcon.image))
        navigationController.hideNavBar()
        setRootViewController(favViewController)
    }

    func goToPlacesDetails(coordinates: CLLocationCoordinate2D, place: Place) {
        let viewModel = PlaceDetailsViewModel(coordinator: self,
                                       place: place,
                                       coordinates: coordinates)
        let viewController = PlaceDetailsViewController(viewModel: viewModel)
        push(viewController)
    }
}
