//
//  PersistantExtension.swift
//  origin
//
//  Created by Misha Causur on 27.02.2022.
//

import Foundation
import GRDB

extension AppDatabase {
    static let shared = makeShared()
    
    private static func makeShared() -> AppDatabase {
        do {
            let fileManager = FileManager()
            let url = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
            let databaseURL = url.appendingPathComponent("database.sqlite")
            let databasePool = try DatabasePool(path: databaseURL.path)
            
            let appDatabase = try AppDatabase(databasePool)
            
            return appDatabase
            
        } catch let error {
            fatalError("Something goes wrong because of \(error.localizedDescription)")
        }
    }
}
