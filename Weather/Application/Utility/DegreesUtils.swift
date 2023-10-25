//
//  DegreesUtils.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import Foundation

class DegreesUtils {
    static func roundOff(degrees: Double) -> String {
        let degreesRounded = String(format: "%.0fº", degrees)
        return degreesRounded
    }
}
