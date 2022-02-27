//
//  ContactModel.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation
import GRDB

struct ContactModel: Codable, FetchableRecord {
    var id, name, phone: String
    var height: Double
    var biography: String
    var temperament: Temperament
    var educationPeriod: EducationPeriod
}

struct EducationPeriod: Codable, FetchableRecord {
    let start, end: Date
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let startString = try container.decode(String.self, forKey: .start)
        let endString = try container.decode(String.self, forKey: .end)
        start = CalendarFormatter.shared.formed(startString)
        end = CalendarFormatter.shared.formed(endString)
    }

    init(start: Date, end: Date) {
        self.start = start
        self.end = end
   }
}

enum Temperament: String, Codable {
    case melancholic = "melancholic"
    case phlegmatic = "phlegmatic"
    case sanguine = "sanguine"
    case choleric = "choleric"
}



