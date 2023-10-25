//
//  UIEdgesInsets+Extensions.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

extension UIEdgeInsets {

    init(top: Int = 0, left: Int = 0, bottom: Int = 0, right: Int = 0) {
        self.init(CGFloat(top),
                  left: CGFloat(left),
                  bottom: CGFloat(bottom),
                  right: CGFloat(right))
    }

    init(_ top: CGFloat = 0,
         left: CGFloat = 0,
         bottom: CGFloat = 0,
         right: CGFloat = 0) {
        self.init(top: top,
                  left: left,
                  bottom: bottom,
                  right: right)
    }

    init(all: CGFloat = 0) {
        self.init(top: all,
                  left: all,
                  bottom: all,
                  right: all)
    }

    init(horizontal: CGFloat = 0,
         vertical: CGFloat = 0) {
        self.init(top: vertical,
                  left: horizontal,
                  bottom: vertical,
                  right: horizontal)
    }

    init(left: CGFloat = 0,
         right: CGFloat = 0,
         vertical: CGFloat = 0) {
        self.init(top: vertical,
                  left: left,
                  bottom: vertical,
                  right: right)
    }

    init(top: CGFloat = 0,
         bottom: CGFloat = 0,
         horizontal: CGFloat = 0) {
        self.init(top: top,
                  left: horizontal,
                  bottom: bottom,
                  right: horizontal)
    }
}
