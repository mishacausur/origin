//
//  DatabaseModel.swift
//  origin
//
//  Created by Misha Causur on 27.02.2022.
//

import Foundation
import GRDB

struct DatabaseModel: Codable, FetchableRecord, MutablePersistableRecord {
    var id, name, phone, biography, start, end: String
    var height: Double
    var temperament: Temperament
}

extension DatabaseModel: TableRecord {
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let phone = Column(CodingKeys.phone)
        static let height = Column(CodingKeys.height)
        static let biography = Column(CodingKeys.biography)
        static let temperament = Column(CodingKeys.temperament)
        static let start = Column(CodingKeys.start)
        static let end = Column(CodingKeys.end)
    }
}

