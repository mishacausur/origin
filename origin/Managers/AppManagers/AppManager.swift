//
//  AppManager.swift
//  origin
//
//  Created by Misha Causur on 27.02.2022.
//

import Foundation
import UIKit
import SwiftUI

class AppManager {
    let queue = DispatchQueue(label: "background", qos: .background, attributes: .concurrent)
    static let shared = AppManager()
    private init() {}
   
    func chackDate() -> Bool {
    
        guard let lastDate = UserDefaults.standard.string(forKey: "lastDate"), let doubleDate = Double(lastDate) else {
            print("true")
            return true
        }
        let date = Date().timeIntervalSince1970
        if Int(date) - Int(doubleDate) > 60 {
            print("true")
            return true
        } else {
            print("false")
            return false
        }
    }
    
    func getDataFromServer(completion: @escaping (Result)->()) {
        queue.async {
            NetworkManager.shared.getData([.one, .two, .three]) { [weak self] contacts in
                defer { withExtendedLifetime(self) {} }
                if !contacts.isEmpty {
                    DispatchQueue.main.async {
                        completion(.success(contacts.sorted { $0.name < $1.name }))
                        print("from interner")
                        UserDefaultsManager.shared.updateValue()
                    }
                } else {
                    completion(.failure(.cantGetData))
                }
            }
        }
    }
    
    func getdataFromDatabase(completion: @escaping (Result) -> ()) {
        queue.async {
            let models = AppDatabase.shared.readContacts()
            let contacts = AppDatabase.shared.createContacts(models)
            completion(.success(contacts.sorted { $0.name < $1.name }))
            print("from database")
        }
    }
}
