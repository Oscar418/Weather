//
//  DateUtil.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/23.
//

import Foundation

class DateUtil {

    private static let dateFormatter = DateFormatter()

    static func getDay(dateAsString: String) -> String? {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let day = dateFormatter.date(from: dateAsString) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            return dayFormatter.string(from: day)
        } else {
            return nil
        }
    }

    static func getDate(timestamp: TimeInterval) -> String {
        guard let userTimeZone = TimeZone.current.abbreviation() else { return "" }
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: userTimeZone)
        let date = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: date)
    }
}
