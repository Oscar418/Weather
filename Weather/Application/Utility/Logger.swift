//
//  Logger.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/25.
//

import os.log
import Foundation

class Logger {
    static let shared = Logger()

    private let log = OSLog(subsystem: Bundle.main.bundleIdentifier!,
                            category: "Logs")

    func logDebug(_ message: String) {
        os_log("%{public}s", log: log, type: .debug, message)
    }
}
