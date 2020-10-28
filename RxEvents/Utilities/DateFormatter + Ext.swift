//
//  DateFormatter + Ext.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import Foundation

extension DateFormatter {
    static var StringFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "E, dd MMM yyyy HH:mm"
        return formatter
    }
    
    static var Formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
}
