//
//  HomeViewController.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {

    private let viewModel: HomeViewModelType

    private let contentStack = UIStackView().configureStackView {
        $0.axis = .vertical
        $0.spacing = 12
    }

    private let weatherBackgroundImage = UIImageView().configureImageView {
        $0.contentMode = .scaleAspectFill
        $0.constrainHeight(350)
        $0.clipsToBounds = true
    }

    private let currentDegressStack = UIStackView().configureStackView {
        $0.axis = .vertical
    }

    private let currentDegreeLabel = UILabel().configureLabel {
        $0.font = WeatherTheme.Font.bold36
        $0.textColor = WeatherAsset.Color.white.color
        $0.textAlignment = .center
    }

    private let currentWeatherLabel = UILabel().configureLabel {
        $0.font = WeatherTheme.Font.bold36
        $0.textColor = WeatherAsset.Color.white.color
        $0.textAlignment = .center
    }

    private lazy var lastUpdatedStack = UIStackView().configureStackView {
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(left: 8)
        $0.addArrangedSubview(self.lastUpdateLabel)
    }

    private let lastUpdateLabel = UILabel().configureLabel {
        $0.font = WeatherTheme.Font.regular12
        $0.textColor = WeatherAsset.Color.white.color
        $0.textAlignment = .left
    }

    private let weatherInfoStack = UIStackView().configureStackView {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(top: 8,
                                 horizontal: 16)
    }

    private var separator = UIView().configureView {
        $0.constrainHeight(1)
        $0.backgroundColor = WeatherAsset.Color.white.color
    }

    private let forecastStack = UIStackView().configureStackView {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(horizontal: 16)
    }

    private let locationManager: CLLocationManager = CLLocationManager()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData()
        layoutViews()
    }

    private func layoutViews() {
        view.addSubview(contentStack)
        contentStack.constrainEdges([.top, .left, .right],
                                    ofView: view)

        contentStack.addArrangedSubview(weatherBackgroundImage,
                                        lastUpdatedStack,
                                        weatherInfoStack,
                                        separator,
                                        forecastStack)
        contentStack.setCustomSpacing(0, after: lastUpdatedStack)

        weatherBackgroundImage.addSubview(currentDegressStack)
        currentDegressStack.constrainCenterSuperview()

        currentDegressStack.addArrangedSubview(currentDegreeLabel,
                                               currentWeatherLabel)

        view.addSubview(activityIndicator)
        activityIndicator.constrainCenterSuperview()
    }

    private func getWeatherData() {
        viewModel.hasInternet(completion: { [weak self] hasConnection in
            guard let self = self else { return }
            if hasConnection {
                self.configureLocationServices()
            } else {
                self.populateStoredData()
            }
        })
    }

    private func populateStoredData() {
        viewModel.getStoredWeatherData(completion: { [weak self] weather, forecast in
            guard let self = self,
            let weather = weather,
            let forecast = forecast else { return }
            self.populateData(weather: weather)
            self.populateForecast(forecastList: forecast)
        })
    }

    private func populateData(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.currentDegreeLabel.text = DegreesUtils.roundOff(degrees: weather.main.temp)
            self.lastUpdateLabel.text = "Last updated at: \(DateUtil.getDate(timestamp: weather.date))"

            let weatherStackMin = WeatherInfoStack(weatherTitle: DegreesUtils.roundOff(degrees: weather.main.tempMin),
                                                   weatherSubTitle: "min",
                                                   textAlignment: .left)

            let weatherStackCurrent = WeatherInfoStack(weatherTitle: DegreesUtils.roundOff(degrees: weather.main.temp),
                                                       weatherSubTitle: "current",
                                                       textAlignment: .center)

            let weatherStackMax = WeatherInfoStack(weatherTitle: DegreesUtils.roundOff(degrees: weather.main.tempMax),
                                                   weatherSubTitle: "max",
                                                   textAlignment: .right)

            self.weatherInfoStack.addArrangedSubview(weatherStackMin,
                                                     weatherStackCurrent,
                                                     weatherStackMax)

            if let weatherData = weather.weather.first {
                self.currentWeatherLabel.text = weatherData.main
                self.setBackgroundImage(condition: weatherData.main)
            }
        }
    }

    private func populateForecast(forecastList: [WeatherInfo]) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            forecastList.forEach {
                let weatherIcon = self.getWeatherIcon(condition: $0.weather.first?.main ?? "")
                let temp = DegreesUtils.roundOff(degrees: $0.main.temp)

                self.forecastStack.addArrangedSubview(ForecastStack(day: DateUtil.getDay(dateAsString: $0.dtTxt) ?? "",
                                                                    weatherIcon: weatherIcon,
                                                                    degrees: temp))
            }
        }
    }

    private func setBackgroundImage(condition: String) {
        var backgroundColor = UIColor()
        switch WeatherCondition(stringValue: condition) {
        case .sunny:
            backgroundColor = WeatherAsset.Color.sunny.color
            weatherBackgroundImage.image = WeatherAsset.Image.forestSunny.image
            view.backgroundColor = WeatherAsset.Color.sunny.color
        case .cloudy:
            backgroundColor = WeatherAsset.Color.cloudy.color
            weatherBackgroundImage.image = WeatherAsset.Image.forestCloudy.image
            view.backgroundColor = WeatherAsset.Color.cloudy.color
        case .rainy:
            backgroundColor = WeatherAsset.Color.rainy.color
            weatherBackgroundImage.image = WeatherAsset.Image.forestRainy.image
            view.backgroundColor = WeatherAsset.Color.rainy.color
        case .none:
            break
        }
        viewModel.storeBackgroundColor(color: backgroundColor)
    }

    private func getWeatherIcon(condition: String) -> UIImage {
        switch WeatherCondition(stringValue: condition) {
        case .sunny, .none:
            return WeatherAsset.Image.clear.image
        case .cloudy:
            return WeatherAsset.Image.partlysunny.image
        case .rainy:
            return WeatherAsset.Image.rain.image
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {

    private func configureLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        requestUserLocation()
    }

    private func requestUserLocation() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted,
                .denied,
                .authorizedAlways,
                .authorizedWhenInUse:
            locationManager.requestLocation()
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        viewModel.getCurrentWeather(lat: location.coordinate.latitude,
                                    long: location.coordinate.longitude,
                                    completion: { [weak self] weather in
            guard let self = self else { return }
            self.populateData(weather: weather)
        })

        activityIndicator.startAnimating()
        viewModel.getForecast(lat: location.coordinate.latitude,
                              long: location.coordinate.longitude,
                              completion: { [weak self] forecast in
            guard let self = self else { return }
            self.populateForecast(forecastList: forecast)
        })
    }

    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        Logger.shared.logDebug(error.localizedDescription)
    }
}
