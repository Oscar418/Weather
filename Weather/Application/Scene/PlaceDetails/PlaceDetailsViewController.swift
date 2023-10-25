//
//  PlaceDetailsViewController.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/24.
//

import UIKit
import MapKit

class PlaceDetailsViewController: UIViewController {

    private var viewModel: PlaceDetailsViewModelType
    private var mapView: MKMapView!

    private lazy var weatherDetailsStack = UIStackView().configureStackView {
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(horizontal: 16, vertical: 16)
        $0.axis = .horizontal
        $0.spacing = 12
        $0.backgroundColor = WeatherAsset.Color.white.color
        $0.layer.cornerRadius = 8
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 1
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowColor = WeatherAsset.Color.black.color.cgColor
        $0.addArrangedSubview(self.locationIconView,
                              self.addressDetailsStack,
                              self.weatherTempStack)
    }

    private lazy var locationIconView = UIView().configureView {
        $0.constrainWidth(16)
        $0.addSubview(self.locationIcon)
        self.locationIcon.constrainCenterSuperview()
    }

    private let locationIcon = UIImageView().configureImageView {
        $0.image = WeatherAsset.Image.locationPin.image.withRenderingMode(.alwaysTemplate)
        $0.tintColor = WeatherAsset.Color.black.color
        $0.constrainSquare(16)
    }

    private lazy var addressDetailsStack = UIStackView().configureStackView {
        $0.axis = .vertical
        $0.spacing = 2
        $0.addArrangedSubview(self.streetLabel,
                              self.cityLabel)
    }

    private lazy var streetLabel = UILabel().configureLabel {
        $0.font = WeatherTheme.Font.medium16
        $0.textColor = WeatherAsset.Color.black.color
        $0.text = viewModel.place.placeTitle
    }

    private lazy var cityLabel = UILabel().configureLabel {
        $0.font = WeatherTheme.Font.regular16
        $0.textColor = WeatherAsset.Color.black.color
        $0.text = viewModel.place.placeSubtitle
    }

    private lazy var weatherTempStack = UIStackView().configureStackView {
        $0.axis = .vertical
        $0.spacing = 2
        $0.addArrangedSubview(self.weatherTempLabel,
                              self.weatherCondition)
    }

    private let weatherTempLabel = UILabel().configureLabel {
        $0.font = WeatherTheme.Font.medium16
        $0.textColor = WeatherAsset.Color.blue.color
        $0.textAlignment = .center
    }

    private let weatherCondition = UILabel().configureLabel {
        $0.font = WeatherTheme.Font.medium16
        $0.textColor = WeatherAsset.Color.blue.color
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    init(viewModel: PlaceDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavBar(backgroundColor: WeatherAsset.Color.white.color)
        navigationController?.showNavBar()
        view.backgroundColor = WeatherAsset.Color.white.color
        configureMap()
        layoutViews()
        addAnnotation()
        getWeatherData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.hideNavBar(animated: false)
    }

    private func layoutViews() {
        view.addSubview(mapView)
        mapView.fillSuperview()

        mapView.addSubview(weatherDetailsStack)
        weatherDetailsStack.constrainEdges([.left, .right, .top],
                                           ofView: mapView,
                                           withInsets: .init(top: 16,
                                                             horizontal: 16))
    }

    private func getWeatherData() {
        viewModel.getLocationWeather(completion: { [weak self] weather in
            guard let self = self else { return }
            self.populateData(weather: weather)
        })
    }

    private func populateData(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.weatherTempLabel.text = DegreesUtils.roundOff(degrees: weather.main.temp)

            if let weatherData = weather.weather.first {
                self.weatherCondition.text = weatherData.main
            }
        }
    }
}

extension PlaceDetailsViewController: MKMapViewDelegate {
    private func configureMap() {
        mapView = MKMapView(frame: view.bounds)
        mapView.delegate = self
    }

    private func addAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: viewModel.coordinates.latitude,
                                                       longitude: viewModel.coordinates.longitude)
        annotation.title = viewModel.place.placeTitle
        annotation.subtitle = viewModel.place.placeSubtitle
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: annotation.coordinate,
                                        latitudinalMeters: 1000,
                                        longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
}
