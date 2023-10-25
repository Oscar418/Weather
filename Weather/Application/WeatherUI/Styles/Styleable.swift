//
//  Styleable.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import Foundation

typealias Style<S> = (S) -> Void

/// Styleable provides an API to init and style views in a declarative way
/// Example
/// - Example declaring a UILabel with title styling
/// ```
/// UILabel(LabelStyle.title)
/// ```
protocol Styleable {
    // swiftlint:disable type_name
    associatedtype S
    // swiftlint:enable type_name
    init()
    init(_ styles: Style<S>...)
}

extension Styleable {
    init(_ styles: Style<Self>...) {
        self.init()
        styles.forEach { $0(self) }
    }

    func style(_ styles: Style<Self>...) {
        styles.forEach { $0(self) }
    }
}

infix operator ++: AdditionPrecedence

// swiftlint:disable operator_whitespace
func ++<S>(lhs: @escaping Style<S>, rhs: @escaping Style<S>) -> Style<S> {
    return {
        lhs($0)
        rhs($0)
    }
}
// swiftlint:enable operator_whitespace
