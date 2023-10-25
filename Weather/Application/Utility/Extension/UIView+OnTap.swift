//
//  UIView+OnTap.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/24.
//

import UIKit

class TapGesture: UITapGestureRecognizer {
    let action: (UITapGestureRecognizer) -> Void

    init(tapsRequired: Int = 1, _ action: @escaping (UITapGestureRecognizer) -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        numberOfTapsRequired = tapsRequired
        addTarget(self, action: #selector(TapGesture.didAction(_:)))
    }

    @objc
    func didAction(_ gesture: UITapGestureRecognizer) {
        action(gesture)
    }
}

extension UIView {

    func onTap(tapsRequired: Int = 1, _ action: @escaping (UIGestureRecognizer) -> Void) {
        addGestureWithInteraction(TapGesture(tapsRequired: tapsRequired, action))
    }

    private func addGestureWithInteraction(_ gesture: UIGestureRecognizer) {
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
    }
}
