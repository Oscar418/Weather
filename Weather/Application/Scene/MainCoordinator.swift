//
//  MainCoordinator.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

final class MainCoordinator: Coordinator {

    static let shared = MainCoordinator()
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [String: Coordinator] = [ : ]
    var window: UIWindow?

    func start(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = .white

        guard #available(iOS 13.0, *) else { return }
        window?.overrideUserInterfaceStyle = .unspecified
        window?.makeKeyAndVisible()

        goToHome()
    }

    func goToHome() {
        let coordinator = TabBarCoordinator.shared
        addChildCoordinator(coordinator)
        coordinator.start()
        window?.rootViewController = coordinator.tabBarController
    }
}
