//
//  CalendarFormatter.swift
//  origin
//
//  Created by Misha Causur on 26.02.2022.
//

import Foundation

struct CalendarFormatter {
    
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
    
    func formatted(_ date: Date) -> String {
        let date = calendarFormatted.string(from: date)
        return date
    }
    
    func formed(_ string: String) -> Date {
        guard let date = formatter.date(from: string) else { return Date() }
        return date
    }
}
