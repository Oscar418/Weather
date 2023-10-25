//
//  WeatherInfoStack.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

final class WeatherInfoStack: UIStackView {

    private let weatherTitle: String
    private let weatherSubTitle: String
    private let textAlignment: NSTextAlignment

    private lazy var weatherTitleLabel = UILabel().configureLabel {
        $0.font = WeatherTheme.Font.medium16
        $0.text = weatherTitle
        $0.textColor = WeatherAsset.Color.white.color
        $0.textAlignment = textAlignment
    }

    private lazy var weatherSubTitleLabel = UILabel().configureLabel {
        $0.font = WeatherTheme.Font.regular16
        $0.text = weatherSubTitle
        $0.textColor = WeatherAsset.Color.white.color
        $0.textAlignment = textAlignment
    }

    init(weatherTitle: String,
         weatherSubTitle: String,
         textAlignment: NSTextAlignment) {
        self.weatherTitle = weatherTitle
        self.weatherSubTitle = weatherSubTitle
        self.textAlignment = textAlignment
        super.init(frame: .zero)
        configureViews()
        layoutViews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureViews() {
        axis = .vertical
        spacing = 2
    }

    private func layoutViews() {
        addArrangedSubview(weatherTitleLabel,
                           weatherSubTitleLabel)
    }
}
