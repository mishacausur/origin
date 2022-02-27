//
//  DataManager.swift
//  origin
//
//  Created by Misha Causur on 27.02.2022.
//

import Foundation
import GRDB

final class AppDatabase {
    
    init(_ databaseWriter: DatabaseWriter) throws {
        self.databaseWriter = databaseWriter
        try migrator.migrate(databaseWriter)
    }
    
    private let databaseWriter: DatabaseWriter
    
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.registerMigration("createContact") { database in
            
            try database.create(table: "databaseModel") { contact in
                contact.column("id", .text).notNull().unique()
                contact.column("name", .text).notNull()
                contact.column("phone", .text).notNull()
                contact.column("height", .double).notNull()
                contact.column("biography", .text).notNull()
                contact.column("temperament", .text).notNull()
                contact.column("start", .date).notNull()
                contact.column("end", .date).notNull()
                
            }
        }
        return migrator
    }
    
    func createContacts(_ dataContact: [DatabaseModel]) -> [ContactModel] {
        var contacts: [ContactModel] = []
        for contact in dataContact {
            let cont = ContactModel(id: contact.id, name: contact.name, phone: contact.phone, height: contact.height, biography: contact.biography, temperament: contact.temperament, educationPeriod: EducationPeriod(start: contact.start, end: contact.end))
            contacts.append(cont)
        }
        return contacts
    }
}

extension AppDatabase {
    func saveContact(_ contact: inout ContactModel) throws {
        var cont = DatabaseModel(id: contact.name, name: contact.name, phone: contact.phone, biography: contact.biography, start: contact.educationPeriod.start, end: contact.educationPeriod.end , height: contact.height, temperament: contact.temperament)
        try databaseWriter.write { database in
            do {
                if try !cont.exists(database) {
                    try cont.save(database)
                    print("TRY TO SAVE")
                } else {
                    print("ALREADY EXIST")
                }
            } catch {
                print("OOOOPS")
            }
            
        }
    }
    
    func readContacts() -> [DatabaseModel] {
        let contacts: [DatabaseModel] = try! databaseReader.read({ database in
            try DatabaseModel.fetchAll(database)
        })
        return contacts
    }
}

extension AppDatabase {
    var databaseReader: DatabaseReader {
        databaseWriter
    }
}
