//
//  CalendarFormatter.swift
//  origin
//
//  Created by Misha Causur on 26.02.2022.
//

import Foundation

class CalendarFormatter {
    
    static let shared = CalendarFormatter()
    var formatter = DateFormatter().configure {
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        $0.locale = Locale(identifier: "en_US_POSIX")
    }
    var calendarFormatted = DateFormatter().configure {
        $0.dateFormat = "dd.MM.yyyy"
    }
    let calendar = Calendar.current
    
    private init() {
        
    }
    
    func formatted(_ string: String) -> String {
        guard let start = formatter.date(from: string) else { return "" }
        let date = calendarFormatted.string(from: start)
        return date
    }
    
    func formed(_ string: String) -> Date {
        guard let date = formatter.date(from: string) else { return Date() }
        return date
    }
}
