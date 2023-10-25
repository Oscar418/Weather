//
//  FavViewController.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit
import MapKit

class FavViewController: ScrollStackViewController {

    private var viewModel: FavViewModelType
    private var debounceTimer: Timer?
    private let completer = MKLocalSearchCompleter()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    private lazy var topStackBackgroundView = UIView().configureView {
        $0.backgroundColor = viewModel.getBackgroundColor()
    }

    private lazy var searchView = UIStackView().configureView {
        $0.backgroundColor = WeatherAsset.Color.white.color
        $0.layer.cornerRadius = 20
        $0.layer.borderColor = WeatherAsset.Color.lightGrey.color.cgColor
        $0.layer.borderWidth = 0.5
        $0.addSubview(self.searchTextField)
        self.searchTextField.constrainEdges([.top, .bottom, .right],
                                            ofView: $0,
                                            withInsets: .init(right: 12))
        $0.addSubview(self.locationIcon)
        self.locationIcon.constrainEdges(.left,
                                         ofView: $0,
                                         withInsets: .init(left: 12))
        self.locationIcon.constrainCenterYToSuperview()
        self.searchTextField.constrain(leftTo: self.locationIcon.rightAnchor,
                                       leftConstant: 8)
    }

    private lazy var searchTextField = UITextField().configureTextField {
        $0.constrainHeight(42)
        $0.placeholder = "Search for a place..."
        $0.font = WeatherTheme.Font.regular10
        $0.textColor = WeatherAsset.Color.black.color
        $0.borderStyle = .none
        $0.returnKeyType = .done
        $0.keyboardType = .default
        $0.autocorrectionType = .default
        $0.autocapitalizationType = .none
        $0.contentVerticalAlignment = .center
        $0.delegate = self
    }

    private let locationIcon = UIImageView().configureImageView {
        $0.image = WeatherAsset.Image.locationPin.image.withRenderingMode(.alwaysTemplate)
        $0.tintColor = WeatherAsset.Color.black.color
        $0.constrainSquare(16)
    }

    private let resultsStack = UIStackView().configureStackView {
        $0.isHidden = true
        $0.axis = .vertical
        $0.spacing = 8
        $0.layer.cornerRadius = 8
        $0.backgroundColor = WeatherAsset.Color.white.color
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(vertical: 12)
    }

    private lazy var storedPlacesContentStack = UIStackView().configureStackView {
        $0.isHidden = true
        $0.axis = .vertical
        $0.spacing = 8
        $0.addArrangedSubview(self.storedPlacesHeadingLabel,
                              self.storedPlacesStack)
    }

    private let storedPlacesHeadingLabel = UILabel().configureLabel {
        $0.text = "Your favorites:"
        $0.font = WeatherTheme.Font.regular16
        $0.textColor = WeatherAsset.Color.white.color
    }

    private let storedPlacesStack = UIStackView().configureStackView {
        $0.axis = .vertical
        $0.spacing = 8
        $0.layer.cornerRadius = 8
        $0.backgroundColor = WeatherAsset.Color.white.color
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(vertical: 12)
    }

    init(viewModel: FavViewModelType) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getStoredPlaces()
        hideKeyboardOnTap()
        configureSearchCompleter()
        layoutViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = viewModel.getBackgroundColor()
        navigationController?.hideNavBar()
    }

    override func configureViews() {
        super.configureViews()
        mainStack.spacing = 8
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.layoutMargins = .init(top: 64, bottom: 16, horizontal: 16)
    }

    override func layoutViews() {
        super.layoutViews()
        view.addSubview(topStackBackgroundView)
        topStackBackgroundView.constrainEdges([.top, .left, .right],
                                              ofView: view)

        view.addSubview(searchView)
        searchView.constrainEdges([.top, .left, .right],
                                  ofGuide: view.safeAreaLayoutGuide,
                                  withInsets: .init(top: 16, horizontal: 16))

        topStackBackgroundView.constrain(bottomTo: searchView.bottomAnchor,
                                         bottomConstant: -6)

        mainStack.addArrangedSubview(resultsStack,
                                     storedPlacesContentStack)

        view.addSubview(activityIndicator)
        activityIndicator.constrainCenterSuperview()
    }

    private func configureSearchCompleter() {
        completer.delegate = self
        completer.resultTypes = .address
    }

    private func getStoredPlaces() {
        guard let storedPlaces = viewModel.fectchStoredPlaces() else { return }
        storedPlacesStack.removeAllArrangedSubviews()
        storedPlacesContentStack.isHidden = storedPlaces.count == 0
        storedPlaces.forEach {
            let placesStack = PlacesStack(place: $0,
                                          canDelete: true)
            placesStack.onDeletePlace = { [weak self] place in
                guard let self = self else { return }
                self.viewModel.removePlace(place: place)
                self.getStoredPlaces()
            }

            placesStack.onSelectPlace = { [weak self] place in
                guard let self = self else { return }
                self.searchCoordinatesForAddress(place: place)
            }

            let separator = UIView().configureView {
                $0.constrainHeight(1)
                $0.backgroundColor = WeatherAsset.Color.lightGrey.color
            }

            storedPlacesStack.addArrangedSubview(placesStack,
                                                 separator)
        }
    }

    private func searchCoordinatesForAddress(place: Place) {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        let searchRequest = MKLocalSearch.Request()
        let entireAddress = place.placeTitle + " " + place.placeSubtitle
        searchRequest.naturalLanguageQuery = entireAddress

        let search = MKLocalSearch(request: searchRequest)
        search.start { response, _ in
            if let response = response,
               let firstPlacemark = response.mapItems.first?.placemark {
                let coordinate = firstPlacemark.coordinate
                self.activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
                self.viewModel.goToPlaceDetails(coordinates: coordinate,
                                                place: place)
            }
        }
    }

    private func addPlaces(places: [MKLocalSearchCompletion]) {
        showHideResults(shouldHide: false)
        resultsStack.removeAllArrangedSubviews()
        places.forEach {
            let place = Place(placeTitle: $0.title,
                              placeSubtitle: $0.subtitle)
            let placesStack = PlacesStack(place: place)
            placesStack.onSelectPlace = { [weak self] place in
                guard let self = self else { return }
                self.showHideResults(shouldHide: true)
                self.viewModel.storePlace(place: place)
                self.getStoredPlaces()
            }

            let separator = UIView().configureView {
                $0.constrainHeight(1)
                $0.backgroundColor = WeatherAsset.Color.lightGrey.color
            }

            resultsStack.addArrangedSubview(placesStack,
                                            separator)
        }
    }

    private func showHideResults(shouldHide: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.resultsStack.isHidden = shouldHide
        }
    }
}

extension FavViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let suggestions = completer.results
        addPlaces(places: suggestions)
    }
}

extension FavViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.completer.queryFragment = newText
        }
        return true
    }
}
