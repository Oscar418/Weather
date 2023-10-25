//
//  Network.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/25.
//

import Network

final class Network {

    static let shared = Network()

    func hasInternetAccess(completion: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")

        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                completion(true)
            } else {
                completion(false)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            monitor.cancel()
        }
    }
}
