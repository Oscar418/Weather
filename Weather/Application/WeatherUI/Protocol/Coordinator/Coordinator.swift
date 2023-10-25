//
//  Coordinator.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import Foundation

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [String: Coordinator] { get set }

    func start()
}

extension Coordinator {
    var identifier: String { String(describing: type(of: self)) }
    func start() { }
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators[coordinator.identifier] = coordinator
        coordinator.parentCoordinator = self
    }
}
