//
//  AppManager.swift
//  origin
//
//  Created by Misha Causur on 27.02.2022.
//

import Foundation
import UIKit
import os.log

final class AppManager {
    
    typealias Completion = (Result <[ContactModel], AppError>) -> Void
    
    let queue = DispatchQueue(label: "background", qos: .background, attributes: .concurrent)
    static let shared = AppManager()
    private init() {}
   
    final func chackDate() -> Bool {
    
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
    
    final func getDataFromServer(completion: @escaping Completion) {
        if #available(iOS 12.0, *) {
            os_signpost(.begin, log: .point, name: "loadData")
        }
        queue.async {
            NetworkManager.shared.getData([.one, .two, .three]) { result in
                if #available(iOS 12.0, *) {
                    os_signpost(.end, log: .point, name: "loadData")
                } 
                switch result {
                case .success(let contacts):
                    DispatchQueue.main.async {
                        completion(.success(contacts.sorted { $0.name < $1.name }))
                        print("from interner")
                        UserDefaultsManager.shared.updateValue()
                    }
                case .failure(_):
                    completion(.failure(.cantGetData))
                }
            }
        }
    }
    
    final func getdataFromDatabase(completion: @escaping Completion) {
        queue.async {
            let models = AppDatabase.shared.readContacts()
            let contacts = AppDatabase.shared.createContacts(models)
            completion(.success(contacts.sorted { $0.name < $1.name }))
            print("from database")
        }
    }
}
