//
//  FavViewModel.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit
import CoreLocation

protocol FavViewModelType {
    func getBackgroundColor() -> UIColor
    func fectchStoredPlaces() -> [Place]?
    func storePlace(place: Place)
    func removePlace(place: Place)
    func goToPlaceDetails(coordinates: CLLocationCoordinate2D, place: Place)
}

final class FavViewModel: FavViewModelType {

    private(set) weak var coordinator: FavCoordinator?
    private let dataServiceManager: DataServiceManager
    private let userDefaults = UserDefaults.standard
    private var places = [Place]()

    init(coordinator: FavCoordinator,
         dataServiceManager: DataServiceManager = .shared) {
        self.coordinator = coordinator
        self.dataServiceManager = dataServiceManager
    }

    func getBackgroundColor() -> UIColor {
        dataServiceManager.getBackgroundColor()
    }

    func storePlace(place: Place) {
        guard !places.contains(where: { $0.placeTitle == place.placeTitle
            && $0.placeSubtitle  == place.placeSubtitle }) else { return }
        places.append(place)
        storePlaces()
    }

    func removePlace(place: Place) {
        places.removeAll { $0.placeTitle == place.placeTitle }
        storePlaces()
    }

    func fectchStoredPlaces() -> [Place]? {
        if let data = UserDefaults.standard.data(forKey: "places") {
            do {
                let decoder = JSONDecoder()
                let storedPlaces = try decoder.decode([Place].self, from: data)
                places = storedPlaces
                return storedPlaces
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }

    func goToPlaceDetails(coordinates: CLLocationCoordinate2D,
                          place: Place) {
        coordinator?.goToPlacesDetails(coordinates: coordinates,
                                       place: place)
    }

    private func storePlaces() {
        do {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(places) {
                UserDefaults.standard.set(encoded, forKey: "places")
            }
        }
    }
}
