//
//  Requester.swift
//  origin
//
//  Created by Misha Causur on 16.03.2022.
//

import Foundation

struct Requester: Request {
   
    typealias Response = [ContactModel]
    
    typealias Error = Swift.Error
    
    func perform(then handler: @escaping Handler) {
        handler(.success([ContactModel]()))
    }
}
