//
//  PlacesStack.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/24.
//

import UIKit

final class PlacesStack: UIStackView {

    private let place: Place
    private var canDelete: Bool

    var onSelectPlace: ((Place) -> Void)?
    var onDeletePlace: ((Place) -> Void)?

    private lazy var locationView = UIView().configureView {
        $0.constrainWidth(16)
        $0.addSubview(self.locationImageView)
        self.locationImageView.constrainCenterSuperview()
    }

    private let locationImageView = UIImageView().configureImageView {
        $0.image = WeatherAsset.Image.locationPin.image.withRenderingMode(.alwaysTemplate)
        $0.tintColor = WeatherAsset.Color.lightGrey.color
        $0.constrainSquare(16)
    }

    private let contentStack = UIStackView().configureStackView {
        $0.axis = .vertical
        $0.spacing = 2
        $0.distribution = .fillProportionally
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(vertical: 6)
    }

    private let streetLabel = UILabel().configureLabel {
        $0.font = WeatherTheme.Font.medium16
        $0.textColor = WeatherAsset.Color.black.color
    }

    private let cityLabel = UILabel().configureLabel {
        $0.font = WeatherTheme.Font.regular16
        $0.textColor = WeatherAsset.Color.black.color
    }

    private lazy var favView = UIView().configureView {
        $0.constrainWidth(16)
        $0.addSubview(self.favImageView)
        self.favImageView.constrainCenterSuperview()
    }

    private lazy var favImageView = UIImageView().configureImageView {
        $0.image = canDelete
        ? WeatherAsset.Image.delete.image.withRenderingMode(.alwaysTemplate)
        : WeatherAsset.Image.favIcon.image.withRenderingMode(.alwaysTemplate)
        $0.tintColor = WeatherAsset.Color.black.color
        $0.constrainSquare(16)
    }

    init(place: Place,
         canDelete: Bool = false) {
        self.place = place
        self.canDelete = canDelete
        super.init(frame: .zero)
        configureViews()
        layoutViews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureViews() {
        axis = .horizontal
        spacing = 8
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(horizontal: 12)

        onTap { _ in
            self.onSelectPlace?(self.place)
        }

        favView.onTap { _ in
            guard self.canDelete else { return }
            self.onDeletePlace?(self.place)
        }

        streetLabel.text = place.placeTitle
        cityLabel.text = place.placeSubtitle
    }

    private func layoutViews() {
        addArrangedSubview(locationView,
                           contentStack,
                           favView)

        contentStack.addArrangedSubview(streetLabel,
                                        cityLabel)
    }
}
