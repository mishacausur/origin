//
//  UserDefaultsManager.swift
//  origin
//
//  Created by Misha Causur on 27.02.2022.
//

import Foundation

class UserDefaultsManager {
    
    private let userDefaults = UserDefaults.standard
    
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    final func updateValue() {
        let value = "\(Date().timeIntervalSince1970)"
        userDefaults.setValue(value, forKey: "lastDate")
    }
}
