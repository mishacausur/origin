//
//  UserDefaultsManager.swift
//  origin
//
//  Created by Misha Causur on 27.02.2022.
//

import Foundation

struct UserDefaultsManager {
    
    @Defaults<String>(key: "lastDate") private var newValue: String?
    
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    mutating func updateValue() {
        let value = "\(Date().timeIntervalSince1970)"
        newValue = value
    }
}

@propertyWrapper
struct Defaults<T> {
    let key: String
    private let storage: UserDefaults = .standard
    
    var wrappedValue: T? {
        get {
            return storage.value(forKey: key) as? T
        }
        set {
            storage.setValue(newValue, forKey: key)
            storage.synchronize()
        }
    }
}
