//
//  ForecastStack.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

final class ForecastStack: UIStackView {

    private let day: String
    private let weatherIcon: UIImage
    private let degrees: String

    private lazy var dayLabel = UILabel().configureLabel {
        $0.font = WeatherTheme.Font.medium16
        $0.text = day
        $0.textColor = WeatherAsset.Color.white.color
    }

    private lazy var weatherIconImageView = UIImageView().configureImageView {
        $0.contentMode = .scaleAspectFit
        $0.image = weatherIcon
    }

    private lazy var degreesLabel = UILabel().configureLabel {
        $0.font = WeatherTheme.Font.medium16
        $0.text = degrees
        $0.textColor = WeatherAsset.Color.white.color
        $0.textAlignment = .right
    }

    init(day: String,
         weatherIcon: UIImage,
         degrees: String) {
        self.day = day
        self.weatherIcon = weatherIcon
        self.degrees = degrees
        super.init(frame: .zero)
        configureViews()
        layoutViews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureViews() {
        axis = .horizontal
        spacing = 2
        distribution = .fillEqually
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(vertical: 6)
    }

    private func layoutViews() {
        addArrangedSubview(dayLabel,
                           weatherIconImageView,
                           degreesLabel)
    }
}
