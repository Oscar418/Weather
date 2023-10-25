//
//  UIFont+Extensions.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

extension UIFont {

    class func fixedCustomFont(font: WeatherFont, size: CGFloat) -> UIFont {
        let uiFont: UIFont
        let fontDescriptor = UIFontDescriptor(name: font.rawValue, size: size)
        if self.doesFontExist(fontDescriptor: fontDescriptor) {
            uiFont = UIFont(descriptor: fontDescriptor, size: 0)
        } else {
            uiFont = UIFont.systemFont(ofSize: size)
        }
        return uiFont
    }

    class func doesFontExist(fontDescriptor: UIFontDescriptor) -> Bool {
        let fontName = fontDescriptor
            .fontAttributes[UIFontDescriptor.AttributeName.name] as? String ?? ""
        let fontSize = fontDescriptor.pointSize
        let font = UIFont(name: fontName, size: fontSize)
        return font != nil
    }
}
