//
//  PlaceDetailsViewModel.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/24.
//

import UIKit
import CoreLocation

protocol PlaceDetailsViewModelType {
    var coordinates: CLLocationCoordinate2D { get }
    var place: Place { get }

    func getLocationWeather(completion: @escaping (CurrentWeather) -> Void)
}

final class PlaceDetailsViewModel: PlaceDetailsViewModelType {

    private(set) weak var coordinator: FavCoordinator?

    let coordinates: CLLocationCoordinate2D
    let place: Place

    init(coordinator: FavCoordinator,
         place: Place,
         coordinates: CLLocationCoordinate2D) {
        self.coordinator = coordinator
        self.place = place
        self.coordinates = coordinates
    }

    func getLocationWeather(completion: @escaping (CurrentWeather) -> Void) {
        guard let baseUrl = Bundle.main.infoDictionary?["baseUrl"],
        let appId = Bundle.main.infoDictionary?["appId"] as? String else { return }
        NetworkService<CurrentWeather>().fetchData(from: "\(baseUrl)/weather",
                                                   queryParams: ["lat" : String(coordinates.latitude),
                                                                 "lon": String(coordinates.longitude),
                                                                 "units": "metric",
                                                                 "appid": appId],
                                                   completion: { [] currentWeather in
            guard let currentWeather = currentWeather else { return }
            completion(currentWeather)
        })
    }
}
