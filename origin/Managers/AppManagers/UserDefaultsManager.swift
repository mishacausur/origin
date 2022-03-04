//
//  UserDefaultsManager.swift
//  origin
//
//  Created by Misha Causur on 27.02.2022.
//

import Foundation

struct UserDefaultsManager {
    
    @Defaults<String>(key: "lastDate") private var newValue: String?
    
    static var shared = UserDefaultsManager()
    
    private init() {}
    
    mutating func updateValue() {
        let value = "\(Date().timeIntervalSince1970)"
        newValue = value
    }
}
