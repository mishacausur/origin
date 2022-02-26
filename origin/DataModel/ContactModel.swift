//
//  ContactModel.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation

struct ContactModel: Codable {
    let id, name, phone: String
    let height: Double
    let biography: String
    let temperament: Temperament
    let educationPeriod: EducationPeriod
}

struct EducationPeriod: Codable {
    let start, end: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let startString = try container.decode(String.self, forKey: .start)
        let endString = try container.decode(String.self, forKey: .end)
        start = CalendarFormatter.shared.formatted(startString)
        end = CalendarFormatter.shared.formatted(endString)
    }
}

enum Temperament: String, Codable {
    case melancholic = "melancholic"
    case phlegmatic = "phlegmatic"
    case sanguine = "sanguine"
    case choleric = "choleric"
}
