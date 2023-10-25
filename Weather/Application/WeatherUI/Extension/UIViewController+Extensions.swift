//
//  UIViewController+Extensions.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/24.
//

import UIKit

extension UIViewController {
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    func showAlert(title: String,
                   message: String,
                   buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alert.addAction(alertButton)
        present(alert, animated: true, completion: nil)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }

    func styleNavBar(backgroundColor: UIColor = WeatherAsset.Color.sunny.color) {
        guard let navigationController = self.navigationController else { return }
        let navBar = navigationController.navigationBar
        navBar.isHidden = false
        navigationController.isNavigationBarHidden = false
        navBar.isTranslucent = false

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
            appearance.backgroundColor = backgroundColor
            appearance.shadowColor = backgroundColor
            appearance.buttonAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
            navBar.tintColor = WeatherAsset.Color.black.color
            navBar.standardAppearance = appearance
            navBar.scrollEdgeAppearance = appearance
        } else {
            navBar.shadowImage = UIImage()
            navBar.backgroundColor = .clear
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.tintColor = WeatherAsset.Color.sunny.color
            navBar.backItem?.title = ""
        }
    }
}
