//
//  UIView+Anchors.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import UIKit

extension UIView {
    func constrainHeight(_ height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func constrainWidth(_ width: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func constrainSquare(_ size: CGFloat) {
        constrainWidth(size)
        constrainHeight(size)
    }

    func constrainCenterXToSuperview(offset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
        }
    }

    func constrainCenterYToSuperview(offset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
        }
    }

    func constrainCenterSuperview() {
        constrainCenterXToSuperview()
        constrainCenterYToSuperview()
    }

    func fillSuperview(withInsets insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return }
        constrainEdges(.all, ofView: superview, withInsets: insets)
    }

    func constrainToWidth(of width: NSLayoutDimension,
                          multiplier: CGFloat = 1,
                          constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(
            equalTo: width,
            multiplier: multiplier,
            constant: constant).isActive = true
    }

    func constrainEdges(_ edges: UIRectEdge,
                        ofView view: UIView,
                        withInsets insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        if edges.contains(.left) {
            constraints.append(
                leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: insets.left))
        }
        if edges.contains(.right) {
            constraints.append(
                trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -insets.right))
        }
        if edges.contains(.top) {
            constraints.append(
                topAnchor.constraint(
                    equalTo: view.topAnchor,
                    constant: insets.top))
        }
        if edges.contains(.bottom) {
            constraints.append(
                bottomAnchor.constraint(
                    equalTo: view.bottomAnchor,
                    constant: -insets.bottom))
        }
        NSLayoutConstraint.activate(constraints)
    }

    func constrainEdges(_ edges: UIRectEdge,
                        ofGuide view: UILayoutGuide,
                        withInsets insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        if edges.contains(.left) {
            constraints.append(
                leftAnchor.constraint(
                    equalTo: view.leftAnchor,
                    constant: insets.left))
        }
        if edges.contains(.right) {
            constraints.append(
                rightAnchor.constraint(
                    equalTo: view.rightAnchor,
                    constant: -insets.right))
        }
        if edges.contains(.top) {
            constraints.append(
                topAnchor.constraint(
                    equalTo: view.topAnchor,
                    constant: insets.top))
        }
        if edges.contains(.bottom) {
            constraints.append(
                bottomAnchor.constraint(
                    equalTo: view.bottomAnchor,
                    constant: -insets.bottom))
        }
        NSLayoutConstraint.activate(constraints)
    }

    @discardableResult
    func constrain(topTo top: NSLayoutYAxisAnchor? = nil,
                   leftTo left: NSLayoutXAxisAnchor? = nil,
                   bottomTo bottom: NSLayoutYAxisAnchor? = nil,
                   rightTo right: NSLayoutXAxisAnchor? = nil,
                   centerY: NSLayoutYAxisAnchor? = nil,
                   topConstant: CGFloat = 0,
                   leftConstant: CGFloat = 0,
                   bottomConstant: CGFloat = 0,
                   rightConstant: CGFloat = 0,
                   widthConstant: CGFloat = 0,
                   heightConstant: CGFloat = 0,
                   centerYConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }

        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }

        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }

        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }

        if let centerY = centerY {
            anchors.append(centerYAnchor.constraint(equalTo: centerY, constant: -centerYConstant))
        }

        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }

        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }

        anchors.forEach { $0.isActive = true }

        return anchors
    }
}
