//
//  Defaults.swift
//  origin
//
//  Created by Misha Causur on 04.03.2022.
//

import Foundation

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
