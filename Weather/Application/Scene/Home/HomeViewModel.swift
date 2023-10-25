//
//  HomeViewModel.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

protocol HomeViewModelType {
    func hasInternet(completion: @escaping (Bool) -> Void)
    func getCurrentWeather(lat: Double, long: Double, completion: @escaping (CurrentWeather) -> Void)
    func getForecast(lat: Double, long: Double, completion: @escaping ([WeatherInfo]) -> Void)
    func getStoredWeatherData(completion: @escaping (CurrentWeather?, [WeatherInfo]?) -> Void)
    func storeBackgroundColor(color: UIColor)
}

final class HomeViewModel: HomeViewModelType {

    private(set) weak var coordinator: HomeCoordinator?
    private let dataServiceManager: DataServiceManager
    private let network: Network
    private let userDefaults = UserDefaults.standard

    init(coordinator: HomeCoordinator?,
         dataServiceManager: DataServiceManager = .shared,
         network: Network = .shared) {
        self.coordinator = coordinator
        self.dataServiceManager = dataServiceManager
        self.network = network
    }

    func hasInternet(completion: @escaping (Bool) -> Void) {
        network.hasInternetAccess(completion: completion)
    }

    func getCurrentWeather(lat: Double,
                           long: Double,
                           completion: @escaping (CurrentWeather) -> Void) {
        guard let baseUrl = Bundle.main.infoDictionary?["baseUrl"],
              let appId = Bundle.main.infoDictionary?["appId"] as? String else { return }
        NetworkService<CurrentWeather>().fetchData(from: "\(baseUrl)/weather",
                                                   queryParams: ["lat" : String(lat),
                                                                 "lon": String(long),
                                                                 "units": "metric",
                                                                 "appid": appId],
                                                   completion: { [weak self] currentWeather in
            guard let self = self,
                  let currentWeather = currentWeather else { return }
            self.storeWeatherData(currentWeather, forKey: "weather")
            completion(currentWeather)
        })
    }

    func getForecast(lat: Double,
                     long: Double,
                     completion: @escaping ([WeatherInfo]) -> Void) {
        guard let baseUrl = Bundle.main.infoDictionary?["baseUrl"],
              let appId = Bundle.main.infoDictionary?["appId"] as? String else { return }
        NetworkService<ForecastWeather>().fetchData(from: "\(baseUrl)/forecast",
                                                    queryParams: ["lat" : String(lat),
                                                                  "lon": String(long),
                                                                  "units": "metric",
                                                                  "appid": appId],
                                                    completion: { [weak self] fiveDayForecast in
            guard let self = self,
                  let fiveDayForecast = fiveDayForecast else { return }
            let filteredForecast = self.filterOneTimestampPerDay(from: fiveDayForecast.list)
            self.storeWeatherData(filteredForecast, forKey: "forecast")
            completion(filteredForecast)
        })
    }

    func getStoredWeatherData(completion: @escaping (CurrentWeather?, [WeatherInfo]?) -> Void) {
        var storedWeather: CurrentWeather?
        var storedForecast: [WeatherInfo]?

        if let data = UserDefaults.standard.data(forKey: "weather") {
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(CurrentWeather.self, from: data)
                storedWeather = weather
            } catch {
                Logger.shared.logDebug("error decoding")
            }
        } else {
            Logger.shared.logDebug("no data found")
        }

        if let data = UserDefaults.standard.data(forKey: "forecast") {
            do {
                let decoder = JSONDecoder()
                let forecast = try decoder.decode([WeatherInfo].self, from: data)
                storedForecast = forecast
            } catch {
                Logger.shared.logDebug("error decoding")
            }
        } else {
            Logger.shared.logDebug("no data found")
        }

        completion(storedWeather,
                   storedForecast)
    }

    func storeBackgroundColor(color: UIColor) {
        dataServiceManager.setBackgroundColor(color: color)
    }

    private func storeWeatherData<T: Codable>(_ data: T,
                                              forKey key: String) {
        do {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(data) {
                UserDefaults.standard.set(encoded,
                                          forKey: key)
            }
        }
    }

    private func filterOneTimestampPerDay(from forecastData: [WeatherInfo]) -> [WeatherInfo] {
        var filteredForecast: [WeatherInfo] = []
        var previousDay = -1
        let today = Calendar.current.component(.day, from: Date())
        for forecast in forecastData {
            let currentDay = Calendar.current.component(.day, from: Date(timeIntervalSince1970: forecast.date))
            if currentDay != previousDay || filteredForecast.isEmpty {
                if currentDay != today {
                    filteredForecast.append(forecast)
                }
                previousDay = currentDay
            }
        }
        return filteredForecast
    }
}
